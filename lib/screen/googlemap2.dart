import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/screen/googlemap.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:businesstaxmap/services/locationservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:businesstaxmap/models/location.dart';

import '../landingpage.dart';

class GoMaps2 extends StatefulWidget {
  // final int resval;
  // GoMaps2(this.resval);
  @override
  _GoMaps2State createState() => _GoMaps2State();
}

class _GoMaps2State extends State<GoMaps2> {

  Completer<GoogleMapController> _controller = Completer();


  bool isLoading = true;
  List<Business> businessArray = [];
  String set1,set2,set3,set4,set5,set6,set7,set8,set9;



   _getLocation2() async {

      try{
        BusinessServices _businessServices = BusinessServices();
        var sqlresponse = await _businessServices.getSQLdata2();
        print('businessdata gikan sa sqldb = ${sqlresponse}');

      sqlresponse.forEach((data){
        var bus = Business();
        bus.id = data['id'];
        bus.business_name = data['business_name'];
        bus.is_business_permit = data['is_business_permit'];
        bus.ownership_type = data['ownership_type'];
        bus.gps_longitude = data['gps_longitude'];
        bus.gps_latitude = data['gps_latitude'];

        setState(() {

          businessArray.add(bus);
          _initMarkers2();

        });

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







  List<Marker> myMarker = [];

   void _initMarkers2() async {
    myMarker.clear();
    set1 = null;
    set2 = null;
    for (int i = 0; i < businessArray.length; i++) {
      if(businessArray[i].ownership_type == "single") {
        set3 = "Violet = Single proprietorship";
        setState(() {
          myMarker.add(Marker(
              markerId: MarkerId(businessArray[i].id.toString()),
              position: LatLng(double.parse(businessArray[i].gps_latitude),
                  double.parse(businessArray[i].gps_longitude)),
              infoWindow: InfoWindow(
                title: businessArray[i].business_name,
                snippet: businessArray[i].business_status,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)
          ));
        });
      } else if(businessArray[i].ownership_type == "partnership"){
        set4 = "Cyan = Partnership";
        setState(() {
          myMarker.add(Marker(
            markerId: MarkerId(businessArray[i].id.toString()),
            position: LatLng(double.parse(businessArray[i].gps_latitude),
                double.parse(businessArray[i].gps_longitude)),
            infoWindow: InfoWindow(
              title: businessArray[i].business_name,
              snippet: businessArray[i].business_status,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan
            ),
          ));
        });
      }else if(businessArray[i].ownership_type == "corporation"){
        set5 = "Magenta = Corporation";
        setState(() {
          myMarker.add(Marker(
            markerId: MarkerId(businessArray[i].id.toString()),
            position: LatLng(double.parse(businessArray[i].gps_latitude),
                double.parse(businessArray[i].gps_longitude)),
            infoWindow: InfoWindow(
              title: businessArray[i].business_name,
              snippet: businessArray[i].business_status,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta
            ),
          ));
        });
      }else if(businessArray[i].ownership_type == "cooperative"){
        set6 = "Yellow = Cooperative";
        setState(() {
          myMarker.add(Marker(
            markerId: MarkerId(businessArray[i].id.toString()),
            position: LatLng(double.parse(businessArray[i].gps_latitude),
                double.parse(businessArray[i].gps_longitude)),
            infoWindow: InfoWindow(
              title: businessArray[i].business_name,
              snippet: businessArray[i].business_status,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow
            ),
          ));
        });
      }else {
        print("initmarker2 error");
      }

    }//end of foreach

  }




  int _value = 1;


  void resvalue(int val){
    if(val == 2){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => GoMaps()),
      );

    }
    else if(val == 3){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => GoMaps2()),
      );
    }else{}

  }





  Future<void> _gotoLocation(double lat, double long) async{
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long),zoom: 25,tilt: 50.0,bearing: 45.0,)));

  }



  void mapCreated(controller){
    setState(() {
      _controller = controller;
    });
  }





  @override
  void initState() {
    super.initState();

    businessArray.clear();
  _getLocation2();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ownership Type Maps'),
          leading:  IconButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          }, icon: Icon(Icons.arrow_back)),
        ),
        body: isLoading ? Center(child: CircularProgressIndicator(),) :

        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                  initialCameraPosition:
                  CameraPosition(target: LatLng(7.18906,124.53261),zoom: 10.0),
                  markers: Set.from(myMarker),
                  onMapCreated: (GoogleMapController controller){
                    _controller.complete(controller);
                  }
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Card(
                //color: Colors.transparent,
                child: Container(
                  width: 300,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: set1 == null ? Container() : Text("${set1}")),
                      Center(child: set2 == null ? Container() : Text("${set2}")),
                      Center(child: set3 == null ? Container() : Text("${set3}")),
                      Center(child: set4 == null ? Container() : Text("${set4}")),
                      Center(child: set5 == null ? Container() : Text("${set5}")),
                      // Center(child: set6 != null ? Container() : Text("${set6}")),
                      // Center(child: set7 != null ? Container() : Text("${set7}")),
                      // Center(child: set8 != null ? Container() : Text("${set8}")),
                      // Center(child: set9 != null ? Container() : Text("${set9}")),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                color: Colors.transparent,
                child: Container(

                  height: 80,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: businessArray.length,
                      itemBuilder: (context,index){
                        return Container(
                          width: 300,
                          child: Card(
                            child: ListTile(
                              leading: Icon(Icons.business,size: 40,),
                              title: Flexible(child: Text(this.businessArray[index].business_name,style: TextStyle(fontSize: 13),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                              // subtitle: Text(businessArray[index].ownership_type),
                              trailing: ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    _gotoLocation(double.parse(businessArray[index].gps_latitude),double.parse(businessArray[index].gps_longitude));

                                  });
                                },
                                child: Text("Find"),
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),


            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,0,0,100),
                child: Card(
                  shadowColor: Colors.black,
                  color: Colors.transparent,
                  child: Container(
                    height: 50,
                    width: 250,
                    child: Column(
                      children: [
                        //Text("Select field"),
                        DropdownButton(
                            value: _value,
                            iconEnabledColor:Colors.black,

                            items: [
                              DropdownMenuItem(
                                child: Text("Select"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Business Permit"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text("Ownership Type"),
                                value: 3,
                              ),
                              // DropdownMenuItem(
                              //     child: Text("Third Item"),
                              //     value: 3
                              // ),
                              // DropdownMenuItem(
                              //     child: Text("Fourth Item"),
                              //     value: 4
                              // )
                            ],
                            onChanged: (value) {
                              setState(() {
                                _value = value;
                                resvalue(_value);
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

}
