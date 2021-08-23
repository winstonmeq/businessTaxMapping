import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/services/bitmapgen.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:businesstaxmap/services/locationservices.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:businesstaxmap/models/location.dart';

class GoMaps extends StatefulWidget {
  @override
  _GoMapsState createState() => _GoMapsState();
}

class _GoMapsState extends State<GoMaps> {

 Completer<GoogleMapController> _controller = Completer();


  bool isLoading = true;
 List<Business> businessArray = [];

  _getLocation() async {

    try {
      BusinessServices _businessServices = BusinessServices();
      var response = await _businessServices.getBusiness();
      var _list = json.decode(response.body);

      _list.forEach((data){
        var bus = Business();
        bus.id = data['id'];
        bus.business_name = data['business_name'];
        bus.gps_longitude = data['gps_longitude'];
        bus.gps_latitude = data['gps_latitude'];

        setState(() {
          businessArray.add(bus);
          _initMarkers();
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

  @override
  void initState() {
       super.initState();
       _getLocation();

  }



  List<Marker> myMarker = [];

  void _initMarkers() async {

       myMarker.clear();
      for (int i = 0; i < businessArray.length; i++) {
        setState(() {
          myMarker.add(Marker(
              markerId: MarkerId(businessArray[i].id.toString()),
              position: LatLng(double.parse(businessArray[i].gps_latitude), double.parse(businessArray[i].gps_longitude)),
              infoWindow: InfoWindow(
                title: businessArray[i].business_name,
                snippet: businessArray[i].business_status,
              ),
            // icon: icond,
          ));
        });
      }
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Maps'),
         ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : Stack(
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
        alignment: Alignment.bottomLeft,
        child: Card(

          color: Colors.transparent,
          child: Container(
            height: 100,
            child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: businessArray.length,
              itemBuilder: (context,index){
              return Container(
                width: 300,
                child: Card(
                  child: ListTile(
                    title: Text(businessArray[index].business_name),
                    //subtitle: Text(businessArray[index].business_status),
                    trailing: ElevatedButton(
                      onPressed: (){
                      _gotoLocation(double.parse(businessArray[index].gps_latitude),double.parse(businessArray[index].gps_longitude));
                      },
                      child: Text("Location"),
                    ),
                  ),
                ),
              );

            },

            ),
          ),
        ),
      )
       ],
      )
    );
  }

}
