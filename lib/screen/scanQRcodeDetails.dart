import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/screen/photoview.dart';
import 'package:businesstaxmap/screen/qrscanner.dart';
import 'package:businesstaxmap/screen/lineBus.dart';
import 'package:businesstaxmap/screen/mapsperbus.dart';
import 'package:businesstaxmap/screen/taxmap.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'landingpage2.dart';




class scanQRDetails extends StatefulWidget {
  final Business busdata;
  scanQRDetails(this.busdata);
  // const scanQRDetails({Key key}) : super(key: key);




  @override
  _scanQRDetailsState createState() => _scanQRDetailsState();
}

class _scanQRDetailsState extends State<scanQRDetails> {



  busStatus() {
    String response = "Active with extension";
    String response2 = "Active w/o extension";
    String response3 = "Inactive";

    if (this.widget.busdata.business_status == "ACTIVE1") {
      return response;
    } else if (this.widget.busdata.business_status == "ACTIVE2") {
      return response2;
    }else {
      return response3;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingPage2()),
          );
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Business Details"),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("${this.widget.busdata.business_name}",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Address: Purok ${this.widget.busdata.purok},",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        Text(
                          " ${this.widget.busdata.bar_name}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Business Code: ${this.widget.busdata.business_code}",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80.0,
                      width: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: "${this.widget.busdata.owner_picture}",
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_sharp),
                          )),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SizedBox(width: 40,),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.purple,
                            child: Icon(
                              Icons.person,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              "${this.widget.busdata.business_owner_name}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // SizedBox(width: 40,),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.purple,
                            child: Icon(
                              Icons.phone,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "${this.widget.busdata.business_owner_number}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: 30,),
                    Container(
                        height: 80,
                        width: 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaxMap(
                                      this.widget.busdata.id,
                                      this.widget.busdata.business_name,
                                      this.widget.busdata)),
                            );
                          },
                          child: Text("Tax Map",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )),

                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 80,
                        width: 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LineBus(
                                      this.widget.busdata.id,
                                      this.widget.busdata.business_name,
                                      this.widget.busdata)),
                            );
                          },
                          child: Text("Line Business",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        )),

                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        height: 80,
                        width: 80,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapsperBus(
                                      this.widget.busdata.business_name,
                                      double.parse(
                                          this.widget.busdata.gps_latitude),
                                      double.parse(
                                          this.widget.busdata.gps_longitude))),
                            );
                          },
                          child: Column(
                            children: [
                              Text("Maps"),
                              Icon(
                                Icons.map_outlined,
                                size: 60,
                              )
                            ],
                          ),
                        )),
                  ],
                ),

/////////////////////////////////////////////////////////////////
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Representative",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${this.widget.busdata.business_representative}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Is Business Permit:",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.is_business_permit}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Business Status",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Flexible(

                                    child: Text(
                                      "${busStatus()}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Payment Type",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.payment_type}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "FSIC",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.fsic}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Capitalization Amount",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.capitalization_amount}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Gross Sales",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.gross_sale_amount}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Annual Payable",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.annual_amount}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Location Status",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.location_status}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Lessor Name",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.lessor_name}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Ownership Type",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.ownership_type}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Business Permit Status",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.business_permit_status}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Is Notice",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.is_notice}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Notice Remarks",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.notice_remarks}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "FSIC Number",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.fsic_number}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Application Status",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.application_status}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Location Rental Amount",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.location_rental_amount}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Total Male",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.total_male}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              ///////////////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Total Female",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.total_female}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              /////////////////////////////////////////////////////////////////////////////////
                              SizedBox(
                                height: 20,
                              ),

                              Row(
                                children: [
                                  Text(
                                    "Total Employees",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${this.widget.busdata.total_employees}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),

                ///////////////

                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Business Permit Picture",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => imageView(
                                this.widget.busdata,
                                "${this.widget.busdata.business_permit_picture}",
                              )),
                        );
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl:
                            "${this.widget.busdata.business_permit_picture}",
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_sharp),
                          )),
                    ),

                    //////////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Owner Signature Picture",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => imageView(
                                this.widget.busdata,
                                "${this.widget.busdata.owner_signature}",
                              )),
                        );
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: "${this.widget.busdata.owner_signature}",
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_sharp),
                          )),
                    ),
                    //////////////////////////////////////////////////////////////////
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Goods Services Picture",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => imageView(
                                this.widget.busdata,
                                "${this.widget.busdata.goods_services_picture}",
                              )),
                        );
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl:
                            "${this.widget.busdata.goods_services_picture}",
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_sharp),
                          )),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Picture 1",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => imageView(
                                this.widget.busdata,
                                "${this.widget.busdata.picture1}",
                              )),
                        );
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: "${this.widget.busdata.picture1}",
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_sharp),
                          )),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Picture 2",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => imageView(
                                this.widget.busdata,
                                "${this.widget.busdata.picture2}",
                              )),
                        );
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: "${this.widget.busdata.picture2}",
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.image_sharp),
                          )),
                    ),
                  ],
                )
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QRViewExample()),
                  );


                }, child: Text("Scan Again")),
              ),
            )

          ],

        )
    );
  }
}
