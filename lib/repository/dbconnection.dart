import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{

  initDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path,'businessDB');
    var database = await openDatabase(path,version: 1,onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE businessTable(id INTEGER PRIMARY KEY , category INTEGER, business INTEGER, "
            "cat_name TEXT, comment TEXT, is_pushed TEXT, created_by INTEGER)");

    await db.execute(
        "CREATE TABLE businessData(id INTEGER PRIMARY KEY , qrcode INTEGER, qr_code TEXT,  business_code TEXT, business_name TEXT, barangay INTEGER,"
            "bar_name TEXT, purok TEXT, stall_no TEXT, gps_longitude TEXT, gps_latitude TEXT, gps_altitud TEXT, gps_accuracy TEXT,"
             "owner_picture TEXT, goods_services_picture TEXT, business_permit_picture TEXT, business_owner_name TEXT, business_owner_number TEXT,"
              "business_representative TEXT, owner_gender TEXT, ownership_type TEXT, is_business_permit TEXT, business_permit_status TEXT,"
            "is_notice TEXT, notice_remarks TEXT, business_status TEXT, payment_type TEXT, inactive_remarks TEXT, inactive_reason TEXT,"
            "fsic TEXT, fsic_number TEXT, application_status TEXT, capitalization_amount TEXT,gross_sale_amount TEXT, annual_amount TEXT, total_employees INTEGER,"
            "total_male INTEGER, total_female INTEGER, location_status TEXT, location_rental_amount TEXT, lessor_name TEXT, owner_signature TEXT,"
           "collector_signature TEXT, collector_designation TEXT, picture1 TEXT, picture2 TEXT, picture3 TEXT, team INTEGER, created_by INTEGER,"
        "modified_by INTEGER, is_deleted BOOL, submitted_from TEXT, qrcode_url TEXT)");


    await db.execute(
        "CREATE TABLE barangayTable(id INTEGER PRIMARY KEY , barangay_name TEXT)");


    await db.execute(
        "CREATE TABLE categoryTable(id INTEGER PRIMARY KEY , category_name TEXT)");


  }

}