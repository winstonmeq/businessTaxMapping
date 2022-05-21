import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/barangay.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/models/category.dart';
import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:businesstaxmap/screen/editBusiness2.dart';
import 'package:businesstaxmap/screen/lineBus.dart';
import 'package:businesstaxmap/screen/businessDetails.dart';
import 'package:businesstaxmap/screen/search.dart';
import 'package:businesstaxmap/screen/testlinebus.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:businesstaxmap/services/categoryservices.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'landingpage2.dart';


class downloadBusData extends StatefulWidget {
  @override
  _downloadBusData createState() => _downloadBusData();
}


class _downloadBusData extends State<downloadBusData> {


  List<Business> businessArray = [];
  bool isLoading = true;

  _getBusiness() async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var response = await _businessServices.getBusiness();
      var _list = json.decode(response.body);
      print(_list);


      _list['results'].forEach((data) {
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


          _savetoSQL(context, bus);



      });



    }catch(e){

      print(e);



       }

    setState(() {
      isLoading = false;
    });


  }




  _savetoSQL(BuildContext context, Business busdata) async {

    BusinessServices _businessServices = BusinessServices();
    var sqlresponse = await _businessServices.addBusinessSQL(busdata);

    print(sqlresponse);


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
        _saveBarangaySQL(context, bar);



      });



    }catch(e){

      print(e);



    }



  }//end getbarangay


  _saveBarangaySQL(BuildContext context, Barangay barangaydata) async {

    BusinessServices _businessServices = BusinessServices();
    var sqlbarangay = await _businessServices.addBarangaySQL(barangaydata);

    print('sql Barangay result = ${sqlbarangay}');



  }


  _getCategory() async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var response = await _businessServices.getCategory();
      var _list = json.decode(response.body);
      print(_list);

      _list.forEach((data){
        var cat = Category();

        cat.id = data['id'];
        cat.category_name = data['category_name'];


          _saveCategorySQL(context, cat);



      });


    }catch(e){

      print(e);



    }



  }//end getbarangay


  _saveCategorySQL(BuildContext context, Category catdata) async {

    BusinessServices _businessServices = BusinessServices();
    var sqlcategory = await _businessServices.addCategorySQL(catdata);

    print('sql Category result = ${sqlcategory}');


  }



  _getLineBus() async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var response = await _businessServices.downloadLineBus();
      var _list = json.decode(response.body);
      print(_list);

      _list.forEach((data){
        var line = LineBusiness();
        line.id = data['id'];
        line.category = data['category'];
        line.business = data['business'];
        line.cat_name = data['cat_name'];
        line.is_pushed = data['is_pushed'].toString();
        line.created_by = data['created_by'];

       _saveLineBusSQL(context, line);

      });




    }catch(e){

      print(e);



    }

    setState(() {
      isLoading = true;
    });


  }//end getLinebus

  _saveLineBusSQL(BuildContext context, LineBusiness linebusdata) async {

    BusinessServices _businessServices = BusinessServices();
    var sqllinebus = await _businessServices.addToLineBus(linebusdata);

    print('sql Linesbusiness result = ${sqllinebus}');



  }



  delTable() async{
    BusinessServices _businessServices = BusinessServices();
    var result = await _businessServices.delSQLtable();
    print("delete businessData ${result}");

  }

  delBarangay() async{
    BusinessServices _businessServices = BusinessServices();
    var result = await _businessServices.delSQLbarangay();
    print("delete barangay table ${result}");


  }

  delCategory() async{
    BusinessServices _businessServices = BusinessServices();
    var result = await _businessServices.delSQLcategory();
    print("delete category table ${result}");

  }

  delLinesBus() async{
    BusinessServices _businessServices = BusinessServices();
    var result = await _businessServices.delSQLLineBus();
    print("delete linebus table ${result}");

  }


  @override
  void initState() {

    isLoading = false;

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
        title: Text("Download Data"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            // tooltip: 'Search',
            onPressed: () {
            delTable();
            delBarangay();
            delCategory();
            delLinesBus();
            },
          ),
        ],

      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : Center(
        child: ElevatedButton(onPressed: (){

          setState(() {
            isLoading = true;
            delTable();
            delBarangay();
            delCategory();
            delLinesBus();
          });

          _getBusiness();
          _getbarangay();
          _getCategory();
          _getLineBus();



        }, child: Text('Press to download data')),
      )
    );

  }




}


