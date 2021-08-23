import 'dart:convert';
import 'dart:io';

import 'package:businesstaxmap/models/barangay.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class qrcodeBus extends StatefulWidget {
  @override
  _qrcodeBus createState() => _qrcodeBus();
}


class _qrcodeBus extends State<qrcodeBus> {


  List<Business> businessArray = [];
  BusinessServices _businessServices = BusinessServices();

  final Business bus = Business();

  String qr_code1 = "", business_name1;
  _getBusiness() async {
    try{
      //  businessArray = List<Business>();
      var response = await _businessServices.getqrcodeBus();
      var _list = json.decode(response.body);
      print(_list);

      _list.forEach((data) {

        var id = data['id'];
         qr_code1 = data['qr_code'];
        var qrcode = data['qrcode'];
         business_name1 = data['business_name'];
        var barangay = data['barangay'];
        var bar_name = data['bar_name'];
        var purok= data['purok'];
        var stall_no = data['stall_no'];
        var gps_longitude = data['gps_longitude'];
        var gps_latitude = data['gps_latitude'];
        var gps_altitud = data['gps_altitud'];
        var gps_accuracy = data['gps_accuracy'];
        var owner_picture = data['owner_picture'];
        var goods_services_picture = data['goods_services_picture'];
        var business_permit_picture = data['business_permit_picture'];
        var business_owner_name = data['business_owner_name'];
        var business_representative = data['business_representative'];
        var owner_gender = data['owner_gender'];
        var ownership_type = data['ownership_type'];
        var is_business_permit = data['is_business_permit'];
        var business_permit_status = data['business_permit_status'];
        var is_notice = data['is_notice'];
        var business_status = data['business_status'];
        var payment_type = data['payment_type'];
        var inactive_remarks = data['inactive_remarks'];
        var inactive_reason = data['inactive_reason'];
        var fsic = data['fsic'];
        var fsic_number = data['fsic_number'];
        var capitalization_amount = data['capitalization_amount'];
        var gross_sale_amount = data['gross_sale_amount'];
        var total_employees = data['total_employees'];
        var application_status = data['application_status'];
        var total_male = data['total_male'];
        var total_female = data['total_female'];
        var location_status = data['location_status'];
        var location_rental_amount = data['location_rental_amount'];
        var lessor_name = data['lessor_name'];
        var owner_signature = data['owner_signature'];
        var collector_signature = data['collector_signature'];
        var collector_designation = data['collector_designation'];
        var picture1 = data['picture1'];
        var picture2 = data['picture2'];
        var picture3 = data['picture3'];
        var submitted_from = data['submitted_from'];


        setState(() {
          businessArray.add(bus);
        });


      });

    }catch(e){
      print(e);
    }
    print(qr_code1);
  }

  PickedFile imageFile,imageFile2,imageFile3,imageFile4,imageFile5;
  String base64Image;
  File tmpFile;



  Future getImage() async {
    PickedFile pickedImage = await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 10 );
    return pickedImage;
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


  final id = TextEditingController();
  final qr_code = TextEditingController();
  final qrcode = TextEditingController();
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

  int _barValue, _genderValue;

 ChangeText() async{
  qr_code.text = qr_code1;
 }




  @override
  void initState() {
    _getBusiness();
    ChangeText();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Business"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: qr_code,
              decoration: InputDecoration(
                labelText: 'qr_code',
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
              controller: qrcode,
              decoration: InputDecoration(
                labelText: 'qrcode Id',
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
                      hint: Text("${bar_name.text}"),
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
                      // value: _genderValue,
                      hint: Text("${owner_gender.text}"), // Not necessary for Option 1

                      items: [DropdownMenuItem(
                          child: Text("female"),
                          value: 'female'
                      ),
                        DropdownMenuItem(
                          child: Text("male"),
                          value: 'male',
                        ),],
                      onChanged: (value) {
                        setState(() {
                          owner_gender.text = value.toString();
                          // _genderValue = value;
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


                  //bdata.qrcode =
                  // bdata.business_name = business_name.text;
                  // bdata.barangay = int.parse(barangay.text);
                  // bdata.purok = purok.text;
                  // bdata.stall_no = stall_no.text;
                  // bdata.gps_longitude = gps_longitude.text;
                  // bdata.gps_latitude = gps_latitude.text;
                  // bdata.gps_altitud = gps_altitud.text;
                  // bdata.gps_accuracy = gps_accuracy.text;
                  // bdata.owner_picture = "";
                  // bdata.goods_services_picture = "";
                  // bdata.business_permit_picture = "";
                  // bdata.business_owner_name = business_owner_name.text;
                  // bdata.business_owner_number = business_owner_number.text;
                  // bdata.business_representative= business_representative.text;
                  // bdata.owner_gender= owner_gender.text;
                  // bdata.ownership_type= ownership_type.text;
                  // bdata.is_business_permit = is_business_permit.text;
                  // bdata.business_permit_status= business_permit_status.text;
                  // bdata.is_notice= is_notice.text;
                  // bdata.notice_remarks= notice_remarks.text;
                  // bdata.business_status= business_status.text;
                  // bdata.payment_type= payment_type.text;
                  // bdata.inactive_remarks= inactive_remarks.text;
                  // bdata.inactive_reason= inactive_reason.text;
                  // bdata.fsic= fsic.text;
                  // bdata.fsic_number= fsic_number.text;
                  // bdata.application_status= application_status.text;
                  // bdata.capitalization_amount= capitalization_amount.text;
                  // bdata.gross_sale_amount= gross_sale_amount.text;
                  // bdata.total_employees= int.parse(total_employees.text);
                  // bdata.total_male  = int.parse(total_male.text);
                  // bdata.total_female= int.parse(total_female.text);
                  // bdata.location_status= location_status.text;
                  // bdata.location_rental_amount= location_rental_amount.text;
                  // bdata.lessor_name= lessor_name.text;
                  // bdata.owner_signature= "";
                  // bdata.collector_signature= "";
                  // bdata.collector_designation= "";
                  // bdata.picture1= "";
                  // bdata.picture2= "";
                  // bdata.picture3= "";
                  // bdata.team= 1;
                  // bdata.created_by= 1;
                  // bdata.modified_by= 1;
                  // bdata.submitted_from= submitted_from.text;

                //  _businessSend(context,this.widget.busdata.id, bdata);

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




}



