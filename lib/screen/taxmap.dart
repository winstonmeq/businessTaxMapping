import 'dart:convert';

import 'package:businesstaxmap/models/business.dart';

import 'package:businesstaxmap/models/taxmapping.dart';
import 'package:businesstaxmap/screen/businessDetails.dart';
import 'package:businesstaxmap/services/business_services.dart';

import 'package:flutter/material.dart';



class TaxMap extends StatefulWidget {
  final Business busdata;
  final int busId;
  final String busName;
  TaxMap(this.busId, this.busName,this.busdata);

  // const lineBusiness({Key key}) : super(key: key);


  @override
  _TaxMapState createState() => _TaxMapState();
}

class _TaxMapState extends State<TaxMap> {


  bool isLoading = true;

  final comment = TextEditingController();
  BusinessServices busServices = BusinessServices();

  int periodId;
  int period_year;


  _getPeriod() async {
    try {

      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.getPeriod();
      var _list = json.decode(registeredUser.body);
      print("getting fiscal period data");
      print(_list);

      _list.forEach((data){
        periodId = data['id'];
        period_year = data['period_year'];
      });

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



  _sendBusPeriod(BuildContext context, BusinessPeriod data) async {
    try {
      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.sendBusPeriod(data);
      print("sending business period data");
      var _list = json.decode(registeredUser.body);

      print(_list);

    } catch (e) {
      print(e);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => busDetails(this.widget.busdata)),
    );
  }









  @override
  void initState() {
    _getPeriod();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading:  IconButton(onPressed: (){
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => busDetails(this.widget.busdata)),
              // );
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)),
            title: Text("Business Period"),),
          body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView(

            children: [
             Padding(
               padding: const EdgeInsets.all(10.0),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text('Business Name:')
                       ],
                     ),
                   ),
                   //////////////////////////////////
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                             child: Flexible(
                                 child: Text("${this.widget.busdata.business_name}",
                                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                   maxLines: 2,
                                   overflow: TextOverflow.ellipsis,
                                 ))),
                       ],
                     ),
                   ),
                  /////////////////////////////////////////

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text('Period: ${period_year.toString()}',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                       ],
                     ),
                   ),

                 //////////////////////////////////////////////
                  SizedBox(
                    height: 30,
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Text('Comments:',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
                       ],
                     ),
                   ),
                   TextField(
                     controller: comment,
                     textInputAction: TextInputAction.newline,
                     keyboardType: TextInputType.multiline,
                     minLines: 5,
                     maxLines: 12,
                     decoration: InputDecoration(
                       //labelText: 'Comment',
                       labelStyle: TextStyle(fontSize: 12),
                       contentPadding: EdgeInsets.all(10),
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.red, width: 1.0),
                       ),
                       enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.black, width: 1.0),
                       ),
                     ),
                   ),


                 ],
               ),
             )

            ],




          ),
          bottomNavigationBar:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Expanded(
                  child:  ElevatedButton(onPressed: (){

                   var bperiod = BusinessPeriod();

                   bperiod.period = periodId;
                   bperiod.business = this.widget.busId;
                   bperiod.comment = comment.text;
                   bperiod.collector = 2;
                   bperiod.created_by = 2;

                   _sendBusPeriod(context, bperiod);


                  }, child: Text("Save")),
                ),
              )

            ],

          )

      ),
    );


  }
}
