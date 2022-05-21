
import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/screen/editBusiness2.dart';
import 'package:businesstaxmap/screen/getBusiness.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:businesstaxmap/screen/businessDetails.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:screen/screen.dart';
import 'dart:convert';



class SearchBus extends StatefulWidget {
  const SearchBus({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBusState();
}

class _SearchBusState extends State<SearchBus> {



  bool isLoading = false;


  SharedPreferences sharedPreferences;


  final searcgText = TextEditingController();

  List<Business> businessArray = [];


  _searchBus(String searchval) async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var response = await _businessServices.searchBus(searchval);
      var _list = json.decode(response.body);
      print(_list);

      if(_list != " "){

        _list.forEach((data) {
          var bus = Business();

          bus.id = data['id'];
          bus.qr_code = data['qr_code'];
          bus.qrcode = data['qrcode'];
          bus.business_name = data['business_name'];
          bus.barangay = data['barangay'];
          bus.bar_name = data['bar_name'];
          bus.purok = data['purok'];
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

          businessArray.add(bus);

        }
        );

      }else {

        print("not found");
      }





    }catch(e){
      print(e);
    }

   setState(() {
     isLoading = false;
   });
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => GetBusiness()),
          // );
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Search",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,10),
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                //      Icon(Icons.search,color: Colors.grey),
                    Expanded(
                      child: TextField(
                        // textAlign: TextAlign.center,
                        controller: searcgText,
                        autofocus: true,
                        decoration: InputDecoration.collapsed(
                          hintText: ' Search by name or address',
                        ),
                        onChanged: (value) {
                           // setState(() {
                           //  // businessArray.clear();
                           //   _searchBus(searcgText.text);
                           // });
                        },
                      ),
                    ),
                    InkWell(
                      child: Icon(Icons.search_outlined,size: 30, color: Colors.black87,),
                      onTap: () {
                       businessArray.clear();
                        _searchBus(searcgText.text);
                      },
                    )
                  ],
                )
            ),
          ) ,
        ),

      ),
      body: ListView.builder(
          itemCount: businessArray.length,
          itemBuilder:(context,index){
            return Card(
              child: InkWell(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => EditBusiness2(businessArray[index])),
                  );
                },

                child: ListTile(
                    title: Text("${businessArray[index].business_name}"),
                     subtitle: Text('${businessArray[index].bar_name}'),
                  trailing: (ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => busDetails(businessArray[index])),

                      );
                    },child: Text("View"),
                  )
                  ),



                ),
              ),
            );
          }
          )
    );
  }






}
