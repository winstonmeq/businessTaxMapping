import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/models/linebusiness.dart';

import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'landingpage2.dart';


class uploadBusData extends StatefulWidget {
  @override
  _uploadBusData createState() => _uploadBusData();
}


class _uploadBusData extends State<uploadBusData> {


  List<Business> businessArray = [];
  bool isLoading = false;

  _businessSend(context, int id, Business businessdata) async {
    try {

      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.editBusiness(id, businessdata);
      var data = json.decode(registeredUser.body);

    } catch (e) {

      print(e);

    }
    print('sending data');
  }




  _getBusinessSQL() async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var sqlresponse = await _businessServices.getSQLdata2();
      print('businessdata gikan sa sqldb = ${sqlresponse}');


        sqlresponse.forEach((data) {
          var bus = Business();
          bus.id = data['id'];
          bus.qr_code = data['qr_code'];
          bus.qrcode = data['qrcode'];
          bus.business_name = data['business_name'];
          bus.business_code = data['business_code'];
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
          bus.notice_remarks = data['notice_remarks'];
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

          _businessSend(context, bus.id, bus);

        });


    }catch(e){

         print(e);


    }//end catch

          setState(() {
            isLoading = false;
          });




  }//end getbusinessql





  //////////////////////////////////LIne of Business Uploading

  List<LineBusiness> listlinebus = [];

  _getLineBusSQL() async {
    try{
      var _businessServices = BusinessServices();
      var sqlresponse = await _businessServices.getLineBusSQL();
      print("from sql businessTable mao nih gina save sa linebus");
      print(sqlresponse);

      if(sqlresponse != null) {
        sqlresponse.forEach((data) {
          var bil = LineBusiness();
          bil.id = data['id'];
          bil.category = data['category'];
          bil.business = data['business'];
          bil.cat_name = data['cat_name'];
          bil.comment = data['comment'];
          bil.is_pushed = data['is_pushed'];
          bil.created_by = data['created_by'];

          setState(() {
            listlinebus.add(bil);
          });
        });


      }else{
        print("null value");
      }
    }catch(e){
      print(e);
      setState(() {
        isLoading = false;
      });
    }

    listlinebus.forEach((ad) {
      var bdata = LineBusiness();
      bdata.id = ad.id;
      bdata.category = ad.category;
      bdata.business = ad.business;
      bdata.cat_name = ad.cat_name;
      bdata.comment = ad.comment;
      bdata.is_pushed = ad.is_pushed;
      bdata.created_by = ad.created_by;
      _lineBusSend(context, bdata);

    });

  }




  _lineBusSend(BuildContext context, LineBusiness linedata) async {
    try {
      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.sendLineBus(linedata);
      print("sending data");
      var _list = json.decode(registeredUser.body);
      print(_list);


    } catch (e) {
      print(e);



    }

  }







  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
          leading:  IconButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage2()),
            );
          }, icon: Icon(Icons.arrow_back)),
          title: Text("Upload Data"),

        ),
        body: isLoading ? Center(child: CircularProgressIndicator(),) : Center(
          child: ElevatedButton(onPressed: () async {

            setState(() {
              isLoading = true;
            });

              _getBusinessSQL();



          }, child: Text('Press to upload data')),
        )
    );

  }


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
