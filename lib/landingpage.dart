import 'dart:convert';

import 'package:businesstaxmap/main.dart';
import 'package:businesstaxmap/screen/business_screen.dart';
import 'package:businesstaxmap/screen/editBusiness.dart';
import 'package:businesstaxmap/screen/getBusiness.dart';
import 'package:businesstaxmap/screen/getOwner.dart';
import 'package:businesstaxmap/screen/googlemap.dart';
import 'package:businesstaxmap/screen/imagepage.dart';
import 'package:businesstaxmap/screen/owner_screen.dart';
import 'package:businesstaxmap/screen/qrcodebusiness.dart';
import 'package:businesstaxmap/screen/qrscanner.dart';
import 'package:businesstaxmap/screen/scanQRcodeDetails.dart';
import 'package:businesstaxmap/screen/testapi.dart';
import 'package:businesstaxmap/screen/uploadImage.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/business.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  List<Business> businessArray = [];
  bool isLoading = true;


  _getBusiness() async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var response = await _businessServices.getqrcodeBus();
      var _list = json.decode(response.body);
      print(_list);

      _list.forEach((data) {

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
        bus.business_owner_name = data['business_owner_number'];
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
      setState(() {
        isLoading = false;
      });

    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditBusiness(businessArray.single)),
    );

    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState() {
 //   _getBusiness();
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
        Card(
        child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonTheme(
              minWidth: 160,
              child: RaisedButton(
                onPressed: () {
                  _getBusiness();
                },
                color: Colors.orangeAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(Icons.home,size: 55,),
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
              width: 10,
            ),
            ButtonTheme(
              minWidth: 160,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetBusiness()),
                  );
                },
                color: Colors.orangeAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(Icons.library_books,size:55),
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
          height: 10,
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
                      Icon(Icons.home,size: 55,),
                      Text('QR Scanner',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
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
                      Icon(Icons.library_books,size:55),
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
        ],
      ),
      ),
            ],

        ),
          bottomNavigationBar:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Expanded(
                  child:  ElevatedButton(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyApp()),
                    );
                    businessArray.clear();
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
