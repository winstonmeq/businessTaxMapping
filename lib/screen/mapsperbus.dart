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

class MapsperBus extends StatefulWidget {
  final String busname;
  final double lat;
  final double long;
  MapsperBus(this.busname,this.lat,this.long);



  @override
  _MapsperBusState createState() => _MapsperBusState();
}

class _MapsperBusState extends State<MapsperBus> {

  Completer<GoogleMapController> _controller = Completer();


  bool isLoading = true;


  @override
  void initState() {
    super.initState();


  }


  Set<Marker> _createMarker() {
    return {

      Marker(
          markerId: MarkerId(this.widget.busname),
          position: LatLng(this.widget.lat, this.widget.long),
          infoWindow: InfoWindow(title: this.widget.busname),
          rotation:1),

    };

  }







    Future<void> _gotoLocation(double lat, double long) async{
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat,long),zoom: 25,tilt: 50.0,bearing: 45.0,)));

  }



  void mapCreated(controller){
    setState(() {
      _controller = controller;
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Business Maps'),
        ),
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                  initialCameraPosition:
                  CameraPosition(target: LatLng(this.widget.lat,this.widget.long),zoom: 15.0),
                  markers: _createMarker(),
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                 // liteModeEnabled: true,
                  onMapCreated: (GoogleMapController controller){
                    _controller.complete(controller);
                  }
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(45,10,45,0),
                child: Container(
                 // color: Colors.cyan,
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: Card(
                    //color: Colors.transparent,
                    child: ListTile(
                      title: Flexible(child: Text("${this.widget.busname}",maxLines: 2,overflow: TextOverflow.ellipsis,)),
                      //subtitle: Text(businessArray[index].business_status),
                      trailing: ElevatedButton(
                        onPressed: (){
                          _gotoLocation(this.widget.lat,this.widget.long);
                        },
                        child: Text("Find"),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        )
    );
  }

}
