import 'dart:convert';

import 'package:businesstaxmap/landingpage.dart';
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



  bool isLoading = false;

  UsersServices _usersServices = UsersServices();

  _login(BuildContext context, Users user) async {

    var registeredUser = await _usersServices.login(user);
    var data = json.decode(registeredUser.body);
    print(data);
     if(data['auth_token'] != null){
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('token', data['auth_token']);

       print("connect");
       print(_prefs.getString('token'));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LandingPage()),
      );



    } else {
    print('error login');
    setState(() {
      isLoading = false;
    });
    }

  }



 final email = TextEditingController();
  final password = TextEditingController();





  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      controller: email,
      obscureText: false,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: password,
      obscureText: true,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {

          var user = Users();
            user.username = email.text;
            user.password = password.text;
            // user.email ="";
            // user.token = "";
            _login(context, user);

            setState(() {
              isLoading = true;
            });

        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: isLoading ? Center(child: CircularProgressIndicator(),) : ListView(
          children: [
       Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/images/midsayaplogo.gif",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text("BUSINESS TAX MAPPING (BTM)",style: TextStyle(fontSize: 18),),
                  SizedBox(height: 45.0),
                  emailField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButon,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

}
