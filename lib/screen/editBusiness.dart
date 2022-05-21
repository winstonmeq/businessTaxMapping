import 'dart:convert';
import 'dart:io';
import 'package:businesstaxmap/screen/lineBus2.dart';
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

class EditBusiness extends StatefulWidget {
  final Business busdata;
  EditBusiness(this.busdata);

  @override
  _EditBusinessState createState() => _EditBusinessState();
}

class _EditBusinessState extends State<EditBusiness> {


  PickedFile imageFile,imageFile2,imageFile3,imageFile4,imageFile5;
  String base64Image;
  File tmpFile;




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



  //List<String> gender = ['Female','Male'];
  List<String> isbusinesspermit = ['YES','NO',"NONE"];
  List<String> isnotice = ['SERVE','UNSERVE',"NONE"];
  List<String> businesstatus = ['ACTIVE W/O EXTENSION','ACTIVE WITH EXTENSION','INACTIVE',"NONE"];
  List<String> paymenttype= ['ANNUAL','SEMI-ANNUAL','QUARTER',"NONE"];
  List<String> fsicmap = ['YES','NO',"NONE"];
  List<String> locationstatus = ['OWNED','RENTED',"NONE"];
  List<String> applicationstatus = ['NEW','RENEW',"NONE"];
  List<String> inactivereason = ['TEMPORARY CLOSED','SUSPENDED','CLOSED',"NONE"];
  List<String> businesspermitstatus = ['FIRST NOTICE','SECOND NOTICE','FINAL NOTICE','CLOSE',"NONE"];
  List<String> ownershiptype = ["SINGLE PROPRIETOR","PARTNERSHIP", "CORPORATION","COOPERATIVE","NONE"];


  List<Barangay> barangayList = [];



  final id = TextEditingController();
  final qr_code = TextEditingController();
  final qrcode = TextEditingController();
  final business_name = TextEditingController();
  final business_code = TextEditingController();
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
  final annual_amount= TextEditingController(text:'0.00');
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
   String qrcode_url;


  changetext(){
    qr_code.text = this.widget.busdata.qr_code;
    qrcode.text = this.widget.busdata.qrcode.toString();
    business_name.text = this.widget.busdata.business_name;
    business_code.text = this.widget.busdata.business_code;
    barangay.text = this.widget.busdata.barangay.toString();
    bar_name.text = this.widget.busdata.bar_name;
    purok.text = this.widget.busdata.purok;
    stall_no.text = this.widget.busdata.stall_no;
     gps_longitude.text = this.widget.busdata.gps_longitude;
    gps_latitude.text = this.widget.busdata.gps_latitude;
    gps_altitud.text = this.widget.busdata.gps_altitud;
    gps_accuracy.text = this.widget.busdata.gps_accuracy;
     owner_picture.text = this.widget.busdata.owner_picture;
    goods_services_picture.text = this.widget.busdata.goods_services_picture;
    business_permit_picture.text = this.widget.busdata.business_permit_picture;
     business_owner_name.text = this.widget.busdata.business_owner_name;
     business_owner_number.text = this.widget.busdata.business_owner_number;
     business_representative.text= this.widget.busdata.business_representative;
     owner_gender.text= this.widget.busdata.owner_gender;
     ownership_type.text= this.widget.busdata.ownership_type;
    is_business_permit.text=this.widget.busdata.is_business_permit;
    business_permit_status.text= this.widget.busdata.business_permit_status;
     is_notice.text= this.widget.busdata.is_notice;
     notice_remarks.text= this.widget.busdata.notice_remarks;
     business_status.text= this.widget.busdata.business_status;
     payment_type.text= this.widget.busdata.payment_type;
    inactive_remarks.text= this.widget.busdata.inactive_remarks;
  inactive_reason.text= this.widget.busdata.inactive_reason;
    fsic.text= this.widget.busdata.fsic;
    fsic_number.text= this.widget.busdata.fsic_number;
   application_status.text= this.widget.busdata.application_status;
   capitalization_amount.text= this.widget.busdata.capitalization_amount;
    gross_sale_amount.text= this.widget.busdata.gross_sale_amount;
    annual_amount.text= this.widget.busdata.annual_amount;
    total_employees.text= this.widget.busdata.total_employees.toString();
    total_male.text= this.widget.busdata.total_male.toString();
    total_female.text= this.widget.busdata.total_female.toString();
     location_status.text= this.widget.busdata.location_status;
    location_rental_amount.text= this.widget.busdata.location_rental_amount;
   lessor_name.text= this.widget.busdata.lessor_name;
 owner_signature.text= this.widget.busdata.owner_signature;
    collector_signature.text= this.widget.busdata.collector_signature;
    collector_designation.text= this.widget.busdata.collector_designation;
    picture1.text= this.widget.busdata.picture1;
     picture2.text= this.widget.busdata.picture2;
   picture3.text= this.widget.busdata.picture3;
   team.text = this.widget.busdata.team.toString();
  created_by.text = this.widget.busdata.created_by.toString();
   modified_by.text= this.widget.busdata.modified_by.toString();
   is_deleted.text= this.widget.busdata.is_deleted.toString();
  submitted_from.text= this.widget.busdata.submitted_from;
  qrcode_url = this.widget.busdata.qrcode_url;

  print(qrcode_url);
  }






  int _barValue;

  _businessSend(context, int id, Business businessdata) async {
    try {
      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.editBusiness(id,businessdata);
      var data = json.decode(registeredUser.body);
      print(data);
      if (data != null) {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LineBus2(this.widget.busdata.id,this.widget.busdata.business_name, this.widget.busdata),
        ));

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
      BusinessServices _businessServices = BusinessServices();
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
    changetext();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Business"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
               height:90,
              //color: Colors.yellow,
              child: Image.network(
                "${qrcode_url}",
              ),
            ),

            // TextField(
            //   style: TextStyle(fontSize: 16),
            //   keyboardType: TextInputType.visiblePassword,
            //   controller: qr_code,
            //   decoration: InputDecoration(
            //     labelText: 'qr_code',
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
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: business_code,
              decoration: InputDecoration(
                labelText: 'Business Code',
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: business_name,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                 Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        // color: Colors.cyan,
                        border: Border.all()),
                    child: DropdownButton(
                      hint: Text("Select"),
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.text,
              controller: purok,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: stall_no,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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


            // SizedBox(
            //   height: 20,
            // ),
            //
            // Row(
            //   children: [
            //
            //     Expanded(
            //       child: TextField(
            //         style: TextStyle(fontSize: 16),
            //         keyboardType: TextInputType.visiblePassword,
            //         controller: owner_picture,
            //         decoration: InputDecoration(
            //           labelText: "Owner Picture",
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
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(5,1,5,1),
            //       child: Container(
            //         height: 50,
            //         width: 50,
            //         decoration: BoxDecoration(
            //             shape: BoxShape.rectangle,
            //             image: DecorationImage(
            //                 image: imageFile == null
            //                     ? AssetImage('assets/images/folder.png')
            //                     : FileImage(File(imageFile.path)),
            //                 fit: BoxFit.contain)),
            //       ),
            //     ),
            //     ElevatedButton(
            //       onPressed: () async {
            //         final tmpFile = await getImage();
            //
            //         setState(() {
            //           imageFile = tmpFile;
            //           owner_picture.text = basename(imageFile.path).toString();
            //         });
            //       },
            //       child: Text('Camera'),
            //     ),
            //   ],
            // ),

            // SizedBox(
            //   height: 10,
            // ),
            //
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         style: TextStyle(fontSize: 16),
            //         keyboardType: TextInputType.visiblePassword,
            //         controller: goods_services_picture,
            //         decoration: InputDecoration(
            //           labelText: "Good Services Picture",
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
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(5,1,5,1),
            //       child: Container(
            //         height: 50,
            //         width: 50,
            //         decoration: BoxDecoration(
            //             shape: BoxShape.rectangle,
            //             image: DecorationImage(
            //                 image: imageFile2 == null
            //                     ? AssetImage('assets/images/folder.png')
            //                     : FileImage(File(imageFile2.path)),
            //                 fit: BoxFit.contain)),
            //       ),
            //     ),
            //     ElevatedButton(
            //       onPressed: () async {
            //         final tmpFile = await getImage();
            //
            //         setState(() {
            //           imageFile2 = tmpFile;
            //           goods_services_picture.text = basename(imageFile2.path).toString();
            //         });
            //       },
            //       child: Text('Camera'),
            //     ),
            //
            //   ],
            //
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            //
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         style: TextStyle(fontSize: 16),
            //         keyboardType: TextInputType.visiblePassword,
            //         controller: business_permit_picture,
            //         decoration: InputDecoration(
            //           labelText: "Business Permit Picture",
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
            //     Padding(
            //       padding: const EdgeInsets.fromLTRB(5,1,5,1),
            //       child: Container(
            //         height: 50,
            //         width: 50,
            //         decoration: BoxDecoration(
            //             shape: BoxShape.rectangle,
            //             image: DecorationImage(
            //                 image: imageFile3 == null
            //                     ? AssetImage('assets/images/folder.png')
            //                     : FileImage(File(imageFile3.path)),
            //                 fit: BoxFit.contain)),
            //       ),
            //     ),
            //     ElevatedButton(
            //       onPressed: () async {
            //         final tmpFile = await getImage();
            //
            //         setState(() {
            //           imageFile3 = tmpFile;
            //           business_permit_picture.text = basename(imageFile3.path).toString();
            //         });
            //       },
            //       child: Text('Camera'),
            //     ),
            //
            //   ],
            //
            // ),


            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: business_owner_name,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: business_owner_number,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: business_representative,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                //     style: TextStyle(fontSize: 16),
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
                      hint: Text("Gender"), // Not necessary for Option 1

                      items: [
                        DropdownMenuItem(
                        child: Text("FEMALE"),
                        value: 'FEMALE'
                      ),
                        DropdownMenuItem(
                          child: Text("MALE"),
                          value: 'MALE',
                        ),
                        DropdownMenuItem(
                          child: Text(""),
                          value: '',
                        ),

                      ],
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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: ownership_type,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          ownership_type.text = "";
                        }else{
                          ownership_type.text = value;
                        }

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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: is_business_permit,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          is_business_permit.text = "";
                        }else {
                          is_business_permit.text = value;
                        }

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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: business_permit_status,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          business_permit_status.text = "";
                        }else {
                          business_permit_status.text = value;
                        }

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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: is_notice,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          is_notice.text = "";
                        }else {
                          is_notice.text = value;
                        }

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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: notice_remarks,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: business_status,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          business_status.text = "";
                        }else {
                          business_status.text = value;
                        }

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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: payment_type,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          payment_type.text = "";
                        }else {
                          payment_type.text = value;
                        }

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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: inactive_remarks,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: inactive_reason,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          inactive_reason.text = "";
                        }else {
                          inactive_reason.text = value;
                        }

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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: fsic,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          fsic.text ="";
                        }else {
                          fsic.text = value;
                        }

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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: fsic_number,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.number,
              controller: capitalization_amount,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.number,
              controller: gross_sale_amount,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                labelText: 'Gross Sales Amount',
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.number,
              controller: annual_amount,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
              decoration: InputDecoration(
                labelText: 'Annual Payable',
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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: application_status,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          application_status.text = "";
                        }else {
                          application_status.text = value;
                        }

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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    controller: total_employees,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    controller: total_male,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.number,
                    controller: total_female,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                    style: TextStyle(fontSize: 16),
                    keyboardType: TextInputType.visiblePassword,
                    readOnly: true,
                    controller: location_status,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                        if(value == "NONE"){
                          location_status.text = "";
                        }else {
                          location_status.text = value;
                        }

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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.number,
              controller: location_rental_amount,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
              style: TextStyle(fontSize: 16),
              keyboardType: TextInputType.visiblePassword,
              controller: lessor_name,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(fontSize: 16),
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
                        style: TextStyle(fontSize: 16),
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
                        style: TextStyle(fontSize: 16),
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
                        style: TextStyle(fontSize: 16),
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
              height: 30,
            ),
            // TextField(
            //   style: TextStyle(fontSize: 16),
            //   keyboardType: TextInputType.visiblePassword,
            //   controller:  collector_signature,
            //   decoration: InputDecoration(
            //     labelText: 'Collector Signature',
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

            // SizedBox(
            //   height: 10,
            // ),
            // TextField(
            //   style: TextStyle(fontSize: 16),
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
            //   style: TextStyle(fontSize: 16),
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
            //   style: TextStyle(fontSize: 16),
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
            //   style: TextStyle(fontSize: 16),
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
            //         style: TextStyle(fontSize: 16),
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
            //         style: TextStyle(fontSize: 16),
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
            // SizedBox(
            //   height: 10,
            // ),
            // TextField(
            //   style: TextStyle(fontSize: 16),
            //   keyboardType: TextInputType.visiblePassword,
            //   controller:  submitted_from,
            //   decoration: InputDecoration(
            //     labelText: 'Submitted From',
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











            SizedBox(
              height: 10,
            ),

            ButtonTheme(
              minWidth: 160,
              child: RaisedButton(
                onPressed: () {


                  var bdata = Business();

                  bdata.qr_code = qr_code.text;
                  bdata.qrcode = int.parse(qrcode.text);
                  bdata.business_code = business_code.text;
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
                  bdata.annual_amount= annual_amount.text;
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
                  bdata.submitted_from= "Mobile";
                  bdata.qrcode_url = qrcode_url;


                  _businessSend(context,this.widget.busdata.id, bdata);

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

  _showCorrect(context, String msg) {
    setState(() {
     // Navigator.pop(context);
       bar_name.text = "";

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
