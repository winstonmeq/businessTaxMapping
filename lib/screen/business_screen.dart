import 'dart:convert';
import 'dart:io';
import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:http/http.dart' as http;
import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/barangay.dart';
import 'package:businesstaxmap/models/category.dart';
import 'package:businesstaxmap/models/owner.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:businesstaxmap/services/categoryservices.dart';
import 'package:businesstaxmap/services/owner_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/services/country.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';


import 'package:intl/intl.dart';
import 'package:path/path.dart';

class BusinessScreen extends StatefulWidget {
  @override
  _BusinessScreenState createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {


  PickedFile imageFile,imageFile2,imageFile3,imageFile4,imageFile5;
  String base64Image;
  File tmpFile;



  Future getImage() async {
    PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 10 );
    return pickedImage;
  }

  BusinessServices busServices = BusinessServices();
  List<LineBusiness> listlinebus = [];


  _getSQLData() async {
    try{
      listlinebus = <LineBusiness>[];
      var sqlresponse = await _businessServices.getLineBusSQL();
      print(sqlresponse);
      if(sqlresponse.toString() != "[]") {
        sqlresponse.forEach((data) {
          var bil = LineBusiness();
          bil.id = data['id'];
          bil.category = data['category'];
          bil.business = data['business'];
          bil.cat_name = data['cat_name'];
          bil.is_pushed = data['is_pushed'];
          bil.created_by = data['created_by'];

          setState(() {
            listlinebus.add(bil);
          });
        });
      }else {

      }
    }catch(e){

    }
  }





  Position _currentPosition;

  final Geolocator geolocator = Geolocator();

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
     // _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //     Placemark place = p[0];
  //     setState(() {
  //       _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  static final DateTime now = DateTime.now();
  static final DateFormat todaydate = DateFormat('yyyy-MM-dd');
  final String finaltodaydate = todaydate.format(now);



  List<String> gender = ['female','male'];
  List<String> isbusinesspermit = ['yes','no'];
  List<String> isnotice = ['serve','unserve'];
  List<String> businesstatus = ['ACTIVE1','ACTIVE2','INACTIVE'];
  List<String> paymenttype= ['annual','semi-annual','quarterly'];
  List<String> fsicmap = ['yes','no'];
  List<String> locationstatus = ['owned','rented'];
  List<String> applicationstatus = ['new','renew'];
  List<String> inactivereason = ['temporary','suspended','closed'];
  List<String> submittedfrom = ['web','mobile'];
  List<String> businesspermitstatus = ['FIRST','SECOND','FINAL','CLOSURE'];
  List<String> ownershiptype = ["single","partnership", "corporation","cooperative"];

  List<Barangay> barangayList = [];

  BusinessServices _businessServices = BusinessServices();


  // final id = TextEditingController();
  // final qrcode = TextEditingController(text: "wrworwu2o3u4o12uowoe");
  final business_name = TextEditingController();
  final barangay = TextEditingController();
  final bar_name = TextEditingController();
  final purok = TextEditingController();
  final stall_no = TextEditingController();
  final gps_longitude = TextEditingController(text:'0.00');
  final gps_latitude = TextEditingController(text:'0.00');
  final gps_altitud = TextEditingController(text:'0.00');
  final gps_accuracy = TextEditingController(text:'0.00');
  final owner_picture = TextEditingController();
  final goods_services_picture = TextEditingController();
  final business_permit_picture = TextEditingController();
  final business_owner_name = TextEditingController();
  final business_owner_number = TextEditingController();
  final business_representative= TextEditingController();
  final owner_gender= TextEditingController();
  final ownership_type= TextEditingController();
  final is_business_permit=TextEditingController();
  final business_permit_status= TextEditingController();
  final is_notice= TextEditingController();
  final notice_remarks= TextEditingController();
  final business_status= TextEditingController();
  final payment_type= TextEditingController();
  final inactive_remarks= TextEditingController();
  final inactive_reason= TextEditingController();
  final fsic= TextEditingController();
  final fsic_number= TextEditingController();
  final application_status= TextEditingController();
  final capitalization_amount= TextEditingController(text:'0.00');
  final gross_sale_amount= TextEditingController(text:'0.00');
  final total_employees= TextEditingController();
  final total_male= TextEditingController();
  final total_female= TextEditingController();
  final location_status= TextEditingController();
  final location_rental_amount= TextEditingController(text:'0.00');
  final lessor_name= TextEditingController();
  final owner_signature= TextEditingController();
  final collector_signature= TextEditingController();
  final collector_designation= TextEditingController();
  final picture1= TextEditingController();
  final picture2= TextEditingController();
  final picture3= TextEditingController();
  final team= TextEditingController();
  final created_by = TextEditingController();
  final modified_by= TextEditingController();
  final is_deleted= TextEditingController();
  final submitted_from= TextEditingController(text: "mobile");


  upload(String fileName) {
    http.post(Uri.parse('https://btm-101.herokuapp.com/media/media/'), body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
    //  setStatus(result.statusCode == 200 ? result.body : error);
    }).catchError((error) {
     // setStatus(error);
    });
  }

  uploadImg() {
    if (null == tmpFile) {
     // setStatus(error);
      return;
    }

    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }


    int _barValue;
  String _genderValue;

  _businessSend(context, Business businessdata) async {
    try {

      var registeredUser = await _businessServices.sendBusiness(businessdata);

      var _list = json.decode(registeredUser.body);
      print(_list);
      if (_list['url'] != null) {
        print('data save');
      } else {
        print('unable to connect');
      }
      // if (registeredUser.statusCode == 200) {
      //
      //   print("200");
      // } else {
      //   throw Exception('Failed to load');
      // }


    } catch (e) {
      print(e);
    }
  }

  String selectedCat;

  List<Category> arrayCat;


  _getCategory() async {
    try {
      arrayCat = <Category>[];
      var _categoryServices = CategoryServices();
      var registeredUser = await _categoryServices.getCategory();
      var _list = json.decode(registeredUser.body);
      print(_list);

      _list.forEach((data){
        var cat = Category();

        cat.id = data['id'];
        cat.category_name = data['category_name'];

        setState(() {
          arrayCat.add(cat);
        });

      });

    } catch (e) {
      _showError(context, e.toString());
    }
  }

  _getbarangay() async {
    try{

      var response = await _businessServices.getBarangay();
      var _list = json.decode(response.body);
      print(_list);

      _list.forEach((data){
        var bar = Barangay();

        bar.id = data['id'];
        bar.barangay_name = data['barangay_name'];

        setState(() {
          barangayList.add(bar);
        });
      });
    }catch(e){
      print(e);
    }




  }


  @override
  void initState() {
    _getbarangay();
   _getCurrentLocation();
   _getCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Business"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: business_name,
              decoration: InputDecoration(
                labelText: 'Business Name',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                // Expanded(
                //   child: TextField(
                //     style: TextStyle(fontSize: 20),
                //     keyboardType: TextInputType.visiblePassword,
                //     readOnly: true,
                //     controller: bar_name,
                //     decoration: InputDecoration(
                //       labelText: 'Barangay Name',
                //       labelStyle: TextStyle(fontSize: 12),
                //       contentPadding: EdgeInsets.all(5),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.red, width: 1.0),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black, width: 1.0),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                       // color: Colors.cyan,
                        border: Border.all()),
                    child: DropdownButton(
                      hint: Text("Select Barangay"),
                       value: _barValue,
                      onChanged: (value) {
                        setState(() {
                          barangay.text = value.toString();
                          _barValue = value;
                        });
                      },
                      items: barangayList.map((result) {
                        return DropdownMenuItem(
                          child: Container(width:100,child: new Text(result.barangay_name,style: TextStyle(),overflow:TextOverflow.ellipsis,)),
                          value: result.id,
                        );

                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: purok,
              decoration: InputDecoration(
                labelText: 'Purok',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: stall_no,
              decoration: InputDecoration(
                labelText: 'Stall No.',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.visiblePassword,
                        readOnly: true,
                        controller: gps_longitude,
                        decoration: InputDecoration(
                          labelText: "Longitude",
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.visiblePassword,
                        readOnly: true,
                        controller: gps_latitude,
                        decoration: InputDecoration(
                          labelText: "Latitude",
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                    ),
         SizedBox(
           width: 5,
         ),

                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.visiblePassword,
                        readOnly: true,
                        controller: gps_altitud,
                        decoration: InputDecoration(
                          labelText: "Altitude",
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        keyboardType: TextInputType.visiblePassword,
                        readOnly: true,
                        controller: gps_accuracy,
                        decoration: InputDecoration(
                          labelText: "Accuracy",
                          labelStyle: TextStyle(fontSize: 12),
                          contentPadding: EdgeInsets.all(5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                RaisedButton(onPressed: (){
                 if (_currentPosition != null) {
                    _getCurrentLocation();

                    setState(() {
                      gps_longitude.text = _currentPosition.longitude
                          .toStringAsFixed(5);
                      gps_latitude.text = _currentPosition.latitude.toStringAsFixed(
                          5);

                      gps_accuracy.text = _currentPosition.accuracy.toStringAsFixed(
                          5);
                      gps_altitud.text = _currentPosition.altitude.toStringAsFixed(
                          5);
                    });
                    print(_currentPosition);


                  }else {
                   //
                    _showError(context, "Enable Location");
                 }
                },
                  child: Text("Get Position",style: TextStyle(fontSize: 12),),
                ),
              ],
            ),

            SizedBox(
              height: 20,
            ),

            Row(
              children: [

                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    controller: owner_picture,
                    decoration: InputDecoration(
                      labelText: "Owner Picture",
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,1,5,1),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageFile == null
                                ? AssetImage('assets/images/folder.png')
                                : FileImage(File(imageFile.path)),
                            fit: BoxFit.contain)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final tmpFile = await getImage();

                    setState(() {
                      imageFile = tmpFile;
                      owner_picture.text = basename(imageFile.path).toString();
                    });
                  },
                  child: Text('Camera'),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    controller: goods_services_picture,
                    decoration: InputDecoration(
                      labelText: "Good Services Picture",
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,1,5,1),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageFile2 == null
                                ? AssetImage('assets/images/folder.png')
                                : FileImage(File(imageFile2.path)),
                            fit: BoxFit.contain)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final tmpFile = await getImage();

                    setState(() {
                      imageFile2 = tmpFile;
                      goods_services_picture.text = basename(imageFile2.path).toString();
                    });
                  },
                  child: Text('Camera'),
                ),

              ],

            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    controller: business_permit_picture,
                    decoration: InputDecoration(
                      labelText: "Business Permit Picture",
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,1,5,1),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageFile3 == null
                                ? AssetImage('assets/images/folder.png')
                                : FileImage(File(imageFile3.path)),
                            fit: BoxFit.contain)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final tmpFile = await getImage();

                    setState(() {
                      imageFile3 = tmpFile;
                      business_permit_picture.text = basename(imageFile3.path).toString();
                    });
                  },
                  child: Text('Camera'),
                ),

              ],

            ),


            SizedBox(
              height: 10,
            ),
           TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    controller: business_owner_name,
                    decoration: InputDecoration(
                      labelText: 'Owner Name',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: business_owner_number,
              decoration: InputDecoration(
                labelText: 'Owner Number',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: business_representative,
              decoration: InputDecoration(
                labelText: 'Representative',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                // Expanded(
                //   child: TextField(
                //     style: TextStyle(fontSize: 20),
                //     keyboardType: TextInputType.visiblePassword,
                //     readOnly: true,
                //     controller: owner_gender,
                //     decoration: InputDecoration(
                //       labelText: 'Gender',
                //       labelStyle: TextStyle(fontSize: 12),
                //       contentPadding: EdgeInsets.all(5),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.red, width: 1.0),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.black, width: 1.0),
                //       ),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(1),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        // color: Colors.cyan,
                        border: Border.all()),
                    child: DropdownButton(
                      value: _genderValue,
                      hint: Text("Gender"), // Not necessary for Option 1

                      items: [DropdownMenuItem(
                        child: Text("female"),
                        value: 'female',
                      ),
                        DropdownMenuItem(
                          child: Text("male"),
                          value: 'male',
                        ),],
                      onChanged: (value) {
                        setState(() {
                          owner_gender.text = value.toString();
                         _genderValue = value;
                        });
                      },
                    ),
                  ),


                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: ownership_type,
                    decoration: InputDecoration(
                      labelText: 'Ownership Type',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        ownership_type.text = value;
                      });
                    },
                    items: ownershiptype.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: is_business_permit,
                    decoration: InputDecoration(
                      labelText: 'Is Busiiness Permit',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        is_business_permit.text = value;
                      });
                    },
                    items: isbusinesspermit.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: business_permit_status,
                    decoration: InputDecoration(
                      labelText: 'Busiiness Permit Status',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        business_permit_status.text = value;
                      });
                    },
                    items: businesspermitstatus.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: is_notice,
                    decoration: InputDecoration(
                      labelText: 'Is Notice',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        is_notice.text = value;
                      });
                    },
                    items: isnotice.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),



            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: notice_remarks,
              decoration: InputDecoration(
                labelText: 'Notice Remarks',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: business_status,
                    decoration: InputDecoration(
                      labelText: 'Business Status',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        business_status.text = value;
                      });
                    },
                    items: businesstatus.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),


            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: payment_type,
                    decoration: InputDecoration(
                      labelText: 'Payment Type',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        payment_type.text = value;
                      });
                    },
                    items: paymenttype.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: inactive_remarks,
              decoration: InputDecoration(
                labelText: 'Inactive Remarks',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: inactive_reason,
                    decoration: InputDecoration(
                      labelText: 'Inactive Reason',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        inactive_reason.text = value;
                      });
                    },
                    items: inactivereason.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),


            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: fsic,
                    decoration: InputDecoration(
                      labelText: 'FSIC',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        fsic.text = value;
                      });
                    },
                    items: fsicmap.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: fsic_number,
              decoration: InputDecoration(
                labelText: 'FSIC Number',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: capitalization_amount,
              decoration: InputDecoration(
                labelText: 'Capitalization Amount',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: gross_sale_amount,
              decoration: InputDecoration(
                labelText: 'Gross Sale Amount',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: application_status,
                    decoration: InputDecoration(
                      labelText: 'Application Status',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        application_status.text = value;
                      });
                    },
                    items: applicationstatus.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),


           SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.number,
                    controller: total_employees,
                    decoration: InputDecoration(
                      labelText: 'Total Employees',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.number,
                    controller: total_male,
                    decoration: InputDecoration(
                      labelText: 'Total Male',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.number,
                    controller: total_female,
                    decoration: InputDecoration(
                      labelText: 'Total Female',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: location_status,
                    decoration: InputDecoration(
                      labelText: 'Location Status',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        location_status.text = value;
                      });
                    },
                    items: locationstatus.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,

                      );
                    }).toList(),
                  ),
                ),],
            ),

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: location_rental_amount,
              decoration: InputDecoration(
                labelText: 'Locatioin Rental Amount',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: lessor_name,
              decoration: InputDecoration(
                labelText: 'Lessor Name',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),


            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller:  collector_signature,
              decoration: InputDecoration(
                labelText: 'Collector Signature',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),

            // SizedBox(
            //   height: 10,
            // ),
            // TextField(
            //   style: TextStyle(fontSize: 20),
            //   keyboardType: TextInputType.visiblePassword,
            //   controller:  collector_designation,
            //   decoration: InputDecoration(
            //     labelText: 'Collector Designation',
            //     labelStyle: TextStyle(fontSize: 12),
            //     contentPadding: EdgeInsets.all(5),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1.0),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.black, width: 1.0),
            //     ),
            //   ),
            // ),
            //
            //
            // SizedBox(
            //   height: 10,
            // ),
            // TextField(
            //   style: TextStyle(fontSize: 20),
            //   keyboardType: TextInputType.visiblePassword,
            //   controller:  picture1,
            //   decoration: InputDecoration(
            //     labelText: 'Picture 1',
            //     labelStyle: TextStyle(fontSize: 12),
            //     contentPadding: EdgeInsets.all(5),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1.0),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.black, width: 1.0),
            //     ),
            //   ),
            // ),
            //
            // SizedBox(
            //   height: 10,
            // ),
            // TextField(
            //   style: TextStyle(fontSize: 20),
            //   keyboardType: TextInputType.visiblePassword,
            //   controller:  picture2,
            //   decoration: InputDecoration(
            //     labelText: 'Picture2',
            //     labelStyle: TextStyle(fontSize: 12),
            //     contentPadding: EdgeInsets.all(5),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1.0),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.black, width: 1.0),
            //     ),
            //   ),
            // ),
            //
            //
            // SizedBox(
            //   height: 10,
            // ),
            // TextField(
            //   style: TextStyle(fontSize: 20),
            //   keyboardType: TextInputType.visiblePassword,
            //   controller:  picture3,
            //   decoration: InputDecoration(
            //     labelText: 'Picture 3',
            //     labelStyle: TextStyle(fontSize: 12),
            //     contentPadding: EdgeInsets.all(5),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.red, width: 1.0),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.black, width: 1.0),
            //     ),
            //   ),
            // ),
            //
            //
            //
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         style: TextStyle(fontSize: 20),
            //         keyboardType: TextInputType.visiblePassword,
            //         readOnly: true,
            //         controller: team,
            //         decoration: InputDecoration(
            //           labelText: 'Team',
            //           labelStyle: TextStyle(fontSize: 12),
            //           contentPadding: EdgeInsets.all(5),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.red, width: 1.0),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.black, width: 1.0),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //
            //     Expanded(
            //       child: TextField(
            //         style: TextStyle(fontSize: 20),
            //         keyboardType: TextInputType.visiblePassword,
            //         readOnly: true,
            //         controller: is_deleted,
            //         decoration: InputDecoration(
            //           labelText: 'is Deleted?',
            //           labelStyle: TextStyle(fontSize: 12),
            //           contentPadding: EdgeInsets.all(5),
            //           focusedBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.red, width: 1.0),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderSide: BorderSide(color: Colors.black, width: 1.0),
            //           ),
            //         ),
            //       ),
            //     ),
            //
            //
            //   ],
            // ),
            //
            //
            //

            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller:  submitted_from,
                 decoration: InputDecoration(
                labelText: 'Submitted From',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),



            SizedBox(
              height: 10,
            ),

            ButtonTheme(
              minWidth: 160,
              child: RaisedButton(
                onPressed: () {
                 // _showProgress(context);

                  var bdata = Business();


                  //bdata.qrcode = "";
                  bdata.business_name = business_name.text;
                  bdata.barangay = int.parse(barangay.text);
                  bdata.purok = purok.text;
                  bdata.stall_no = stall_no.text;
                  bdata.gps_longitude = gps_longitude.text;
                  bdata.gps_latitude = gps_latitude.text;
                  bdata.gps_altitud = gps_altitud.text;
                  bdata.gps_accuracy = gps_accuracy.text;
                  bdata.owner_picture = "";
                  bdata.goods_services_picture = "";
                  bdata.business_permit_picture = "";
                  bdata.business_owner_name = business_owner_name.text;
                  bdata.business_owner_number = business_owner_number.text;
                  bdata.business_representative= business_representative.text;
                  bdata.owner_gender= owner_gender.text;
                  bdata.ownership_type= ownership_type.text;
                  bdata.is_business_permit = is_business_permit.text;
                  bdata.business_permit_status= business_permit_status.text;
                  bdata.is_notice= is_notice.text;
                  bdata.notice_remarks= notice_remarks.text;
                  bdata.business_status= business_status.text;
                  bdata.payment_type= payment_type.text;
                  bdata.inactive_remarks= inactive_remarks.text;
                  bdata.inactive_reason= inactive_reason.text;
                  bdata.fsic= fsic.text;
                  bdata.fsic_number= fsic_number.text;
                  bdata.application_status= application_status.text;
                   bdata.capitalization_amount= capitalization_amount.text;
                   bdata.gross_sale_amount= gross_sale_amount.text;
                   bdata.total_employees= int.parse(total_employees.text);
                   bdata.total_male  = int.parse(total_male.text);
                   bdata.total_female= int.parse(total_female.text);
                   bdata.location_status= location_status.text;
                   bdata.location_rental_amount= location_rental_amount.text;
                  bdata.lessor_name= lessor_name.text;
                  bdata.owner_signature= "";
                  bdata.collector_signature= "";
                 bdata.collector_designation= "";
                  bdata.picture1= "";
                  bdata.picture2= "";
                  bdata.picture3= "";
                  bdata.team= 1;
                  bdata.created_by= 1;
                  bdata.modified_by= 1;
                  bdata.submitted_from= submitted_from.text;

                 _businessSend(context, bdata);

                },
                color: Colors.orangeAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, size:20,),
                      Text(
                        "SAVE DATA",
                        style: TextStyle(fontSize: 16),
                      ),

                    ],
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }

  _showProgress(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {

          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  _showCorrect(context, String msg) {
    setState(() {
      Navigator.pop(context);
     //  business_code.text = "";
     //  permit_no.text = "";
     //  dti_no.text = "";
     //  business_name.text = "";
     //  ownership_type.text = "";
     //  capital.text = "";
     //  representative.text = "";
     //  contact_no.text = "";
     //  location1.text = '';
     //  location2.text = "";
     //  latitude.text = "";
     //  longitude.text = "";
     //  altitude.text = "";
     //  accuracy.text = "";
     //  location.text = "";
     //  employees_no.text = "";
     //  employees_male.text = "";
     //  employees_female.text = "";
     //  email.text = "";
     // owner.text = "";
     //  business_type.text = "";
     //  category.text = "";
     //  update_by.text = "";
    });
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ],
            ),
          );
        });
  }

  _showError(context, String msg) {
    // setState(() {
    //   Navigator.pop(context);
    // });
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.red),
                ),
              ],
            ),
          );
        });
  }
}
