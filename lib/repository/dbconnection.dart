import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{

  initDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path,'businessDB');
    var database =
    await openDatabase(path,version: 1,onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE businessTable(id INTEGER PRIMARY KEY , category INTEGER, business INTEGER, "
            "cat_name TEXT, is_pushed TEXT, created_by INTEGER)");
  }

}