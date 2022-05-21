
import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:businesstaxmap/screen/scanQRcodeDetails.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:screen/screen.dart';
import 'dart:convert';

import 'landingpage2.dart';


const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }


  bool isLoading = false;
  var flashState = flashOn;
  var cameraState = frontCamera;


  QRViewController controller;
  Barcode result;
  final GlobalKey qrKey = GlobalKey();

  SharedPreferences sharedPreferences;




  List<Business> businessArray = [];


  _getscanQRCode(String code) async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var sqlresponse = await _businessServices.scanQRBusinessName(code);

      print(sqlresponse);

      sqlresponse.forEach((data) {

        var bus = Business();

        bus.id = data['id'];
        bus.qr_code = data['qr_code'];
        bus.qrcode = data['qrcode'];
        bus.business_name = data['business_name'];
        bus.barangay = data['barangay'];
        bus.bar_name = data['bar_name'];
        bus.purok= data['purok'];
        bus.stall_no = data['stall_no'];
        bus.gps_longitude = data['gps_longitude'];
        bus.gps_latitude = data['gps_latitude'];
        bus.gps_altitud = data['gps_altitud'];
        bus.gps_accuracy = data['gps_accuracy'];
        bus.owner_picture = data['owner_picture'];
        bus.goods_services_picture = data['goods_services_picture'];
        bus.business_permit_picture = data['business_permit_picture'];
        bus.business_owner_name = data['business_owner_name'];
        bus.business_owner_number = data['business_owner_number'];
        bus.business_representative = data['business_representative'];
        bus.owner_gender = data['owner_gender'];
        bus.ownership_type = data['ownership_type'];
        bus.is_business_permit = data['is_business_permit'];
        bus.business_permit_status = data['business_permit_status'];
        bus.is_notice = data['is_notice'];
        bus.business_status = data['business_status'];
        bus.payment_type = data['payment_type'];
        bus.inactive_remarks = data['inactive_remarks'];
        bus.inactive_reason = data['inactive_reason'];
        bus.fsic = data['fsic'];
        bus.fsic_number = data['fsic_number'];
        bus.capitalization_amount = data['capitalization_amount'];
        bus.gross_sale_amount = data['gross_sale_amount'];
        bus.total_employees = data['total_employees'];
        bus.application_status = data['application_status'];
        bus.total_male = data['total_male'];
        bus.total_female = data['total_female'];
        bus.location_status = data['location_status'];
        bus.location_rental_amount = data['location_rental_amount'];
        bus.lessor_name = data['lessor_name'];
        bus.owner_signature = data['owner_signature'];
        bus.collector_signature = data['collector_signature'];
        bus.collector_designation = data['collector_designation'];
        bus.picture1 = data['picture1'];
        bus.picture2 = data['picture2'];
        bus.picture3 = data['picture3'];
        bus.submitted_from = data['submitted_from'];
        bus.qrcode_url = data['qrcode_url'];


        setState(() {
          businessArray.add(bus);
        });

      });

    }catch(e){
      print(e);
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>scanQRDetails(businessArray.single),
    )
    );
   // isLoading = false;
  }





  @override
  void initState(){

    initPlatformState();
    super.initState();
  }

  initPlatformState() async {
    // Get the current brightness:
    double brightness = await Screen.brightness;

// Set the brightness:
    Screen.setBrightness(0.5);
// Check if the screen is kept on:
    bool isKeptOn = await Screen.isKeptOn;
// Prevent screen from going into sleep mode:
    Screen.keepOn(true);
  }



  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
     // backgroundColor: Colors.lightGreen,
      body:  isLoading ? Center(child: CircularProgressIndicator(),) : SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Stack(
                children: <Widget>[
                 Container(
                    child:  QRView(
                      key: qrKey,
                      onQRViewCreated: _onQRViewCreated,
                      overlay: QrScannerOverlayShape(
                       // borderColor: Colors.lightGreenAccent,
                        borderRadius: 20,
                        overlayColor: const Color.fromRGBO(0, 0, 0, 20),
                        borderLength: 60,
                        borderWidth: 1,
                        cutOutSize: 250,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: (){
                            if(result != null) {
                              isLoading = true;
                              _getscanQRCode(result.code);
                            }

                          },child: Text("Scan QR Code"),
                         ),


                      )
                      ),
                  Expanded(

                      flex: 1,
                      child: Padding(

                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // background
                            onPrimary: Colors.white, ),// foreground
                            onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage2()),
                            );

                          },child: Text("Home"),
                        ),
                      )
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }




  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
  }


  Future<void> _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
       result = scanData;
      });
    });
  }



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }




}
