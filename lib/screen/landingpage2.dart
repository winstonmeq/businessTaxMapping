import 'dart:convert';

import 'package:businesstaxmap/main.dart';
import 'package:businesstaxmap/screen/UploadBus.dart';
import 'package:businesstaxmap/screen/addBusiness.dart';

import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/screen/downloadBusiness.dart';
import 'package:businesstaxmap/screen/getBusiness2.dart';
import 'package:businesstaxmap/screen/qrscanner.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getBusiness.dart';
import 'googlemap.dart';


class LandingPage2 extends StatefulWidget {
  @override
  _LandingPage2State createState() => _LandingPage2State();
}

class _LandingPage2State extends State<LandingPage2> {


  bool isLoading = true;




  @override
  void initState() {

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Business Tax Mapping'),
          ),
          body: ListView(

            children: [
              Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 160,
                        child: RaisedButton(
                          onPressed: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => addBusinessOff()),
                              );


                          },
                          color: Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.business_sharp,size: 40,),
                                Text(
                                  'New Business',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 20,
                      ),

                      ButtonTheme(
                        minWidth: 160,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GetBusiness2()),
                            );
                          },
                          color: Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.library_books,size:40),
                                Text(
                                  'List Business',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 160,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QRViewExample()),
                            );
                          },
                          color: Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.qr_code_scanner,size: 40,),
                                Text('QR Scanner',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ButtonTheme(
                        minWidth: 160,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GoMaps()),
                            );
                          },
                          color: Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.map_sharp,size:40),
                                Text('Mapping',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        minWidth: 160,
                        child: RaisedButton(
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => uploadBusData()),
                            );


                          },
                          color: Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.cloud_upload,size: 40,),
                                Text(
                                  'Upload',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: 20,
                      ),

                      ButtonTheme(
                        minWidth: 160,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => downloadBusData()),
                            );
                          },
                          color: Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.cloud_download_outlined,size:40,color: Colors.pinkAccent,),
                                Text(
                                  'Download',
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),



                ],
              ),
            ],

          ),
          bottomNavigationBar:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Expanded(
                  child:  ElevatedButton(onPressed: () async{
                    SharedPreferences _prefs = await SharedPreferences.getInstance();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp()),
                    );

                    _prefs.clear();
                    isLoading = true;

                  }, child: Text("Logout!")),
                ),
              )

            ],

          )
      ),
    );
  }
}
