import 'dart:convert';

import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/loginpage.dart';
import 'package:businesstaxmap/screen/landingpage2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:businesstaxmap/models/users.dart';
import 'package:businesstaxmap/services/users_services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bussiness Tax Mapping',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // textTheme: const TextTheme(
        //   button: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        //   headline3: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        //   headline4: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(fontSize: 30.0, fontStyle: FontStyle.italic),
        //   bodyText1: TextStyle(fontSize: 8.0, fontFamily: 'Hind'),
        //   subtitle2: TextStyle(fontSize: 20.0, fontFamily: 'Hind'),
        // ),
      ),
      home: MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Logincheck() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print('this is my token to be check ${_prefs.getString('token')}');

    if(_prefs.getString('token') != null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage2()),
      );

    }else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => loginpage()),
      );

    }


  }


  @override
  void initState() {
    Logincheck();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold();
  }
}
