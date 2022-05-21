import 'dart:convert';

import 'package:businesstaxmap/screen/landingpage2.dart';
import 'package:businesstaxmap/services/users_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'landingpage.dart';
import 'models/users.dart';



class loginpage extends StatefulWidget {
  const loginpage({Key key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool isLoading = false;


  UsersServices _usersServices = UsersServices();

  _login(BuildContext context, Users user) async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();

      var registeredUser = await _usersServices.login(user);
      var data = json.decode(registeredUser.body);
      print(data);

      if (data['auth_token'] != null) {
        _prefs.setString('token', data['auth_token']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage2()),
        );
        print("connect");
        print(_prefs.getString('token'));
      } else {
        print('error login');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
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
          hintText: "Username",
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    // final offlineButon = Material(
    //   elevation: 5.0,
    //   borderRadius: BorderRadius.circular(30.0),
    //   color: Color(0xff01A0C7),
    //   child: MaterialButton(
    //     minWidth: MediaQuery.of(context).size.width,
    //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => LandingPage2()),
    //       );
    //     },
    //     child: Text("Offline",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    //   ),
    // );



    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Center(
          child: isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : ListView(
            children: [
              Container(
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
                      Text(
                        "BUSINESS TAX MAPPING (BTM)",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 45.0),
                      emailField,
                      SizedBox(height: 25.0),
                      passwordField,
                      SizedBox(
                        height: 35.0,
                      ),
                      loginButon,

                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/taxmap.jpg"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
