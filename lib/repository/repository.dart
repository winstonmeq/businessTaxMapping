import 'dart:convert';

import 'package:businesstaxmap/repository/dbconnection.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


class Repository {

  DatabaseConnection _connection;
  String _baseUrl = 'https://btm-101.herokuapp.com/api/v1';
 // String _baseUrl = 'https://mid-btm.herokuapp.com/api';
  String _baseUrl2 = 'https://about.google/static/data/';
  var url =
  Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

  Repository(){
    _connection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if(_database != null)
      return _database;
    _database = await _connection.initDatabase();
    return _database;
  }


  var token;

  _getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
  }
  _setHeaders()=>{
    // 'Content-type' : 'application/json',
    // 'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'

  };



  httpGet(String api) async {
    await _getToken();
    return await http.get(Uri.parse(_baseUrl + "/" + api),headers: _setHeaders());
  }

  httpGet2(String api, int busId) async {
    await _getToken();
    return await http.get(Uri.parse(_baseUrl + "/" + api + busId.toString()));
  }


  // httpPost(String api, data) async {
  //  // await _getToken();
  //   return await http.post(Uri.parse(_baseUrl + "/" + api), body: jsonEncode(data), headers: _setHeaders());
  // }

  httpPost(String api, data) async {
     await _getToken();
     print('this my token ${token}');
    return await http.post(Uri.parse(_baseUrl + "/" + api), body: data, headers: _setHeaders());
  }

  // httpPost2(String api, data) async {
  //   await _getToken();
  //   print('this my token ${token}');
  //   return await http.post(Uri.parse(_baseUrl + "/" + api), body: data);
  // }


  httpPut(String api , int id, data) async {
    await _getToken();
    print('this my token ${token}');
    return await http.put(Uri.parse(_baseUrl + "/"+ api + id.toString() + "/"), body:data, headers: _setHeaders());
  }

  httpPatcher(String api , int id, data) async {
    await _getToken();
    print('this my token ${token}');
    return await http.put(Uri.parse(_baseUrl + "/"+ api + id.toString() + "/"), body:data, headers: _setHeaders());
  }

  httpDelete(String api , int id) async {
    await _getToken();
    print('this my token ${token}');
    return await http.delete(Uri.parse(_baseUrl + "/"+ api + id.toString() + "/"), headers: _setHeaders());
  }


  httpScanQR(String api , String code) async {
    // await _getToken();
    // print('this my token ${token}');
    return await http.get(Uri.parse(_baseUrl + "/" + api + code));
  }




  httplogin(String api, data) async {
     return await http.post(Uri.parse(_baseUrl + "/" + api), body: data,);
  }




  httpGetCategory(String api) async {
    return await http.get(Uri.parse(_baseUrl + "/" + api));
  }


  httpGet3(String api) async {
    return await http.get(Uri.parse(_baseUrl2 + "/" + api));
  }

  // httpGetById(String api, categoryId) async {
  //   return await http.get(_baseUrl + "/" + api + "/" + categoryId.toString());
  // }
  //
  //
  // httpPut(String api, int getId, data, ) async {
  //   return await http.put(_baseUrl + "/" + api + getId.toString() + "/" , body: data );
  // }




  getAllLocal(table) async {
    var conn = await database;
    return await conn.query(table);
  }

  saveLocal(table, data) async {
    var conn = await database;
    return await conn.insert(table, data);
  }

  updateLocal(table, columnName, data) async {
    var conn = await database;
    return await conn.update(table, data, where: '$columnName =?', whereArgs: [data['id']]);
  }

  getLocalByCondition(table, columnName, conditionalValue) async {
    var conn = await database;
    return await conn.rawQuery('SELECT * FROM $table WHERE $columnName=?', ['$conditionalValue']);
  }


  deleteLocalById(table, id) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table WHERE id = $id");
  }

  deleteLocal(table) async {
    var conn = await database;
    return await conn.rawDelete("DELETE FROM $table");
  }


}