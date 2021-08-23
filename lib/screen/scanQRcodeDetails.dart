import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/screen/qrscanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class scanQRDetails extends StatefulWidget {
  final Business busdata;
  scanQRDetails(this.busdata);
  // const scanQRDetails({Key key}) : super(key: key);




  @override
  _scanQRDetailsState createState() => _scanQRDetailsState();
}

class _scanQRDetailsState extends State<scanQRDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          );
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Business Details"),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 10,),
                        Text("Business Name:"),
                        SizedBox(height: 3,),
                        Text("Barangay:"),
                        SizedBox(height: 3,),
                        Text("Purok:"),
                        SizedBox(height: 3,),
                        Text("Stall No.:"),
                        SizedBox(height: 3,),
                        Text("Business Owner Name:"),
                        SizedBox(height: 3,),
                        Text("Business Owner Number:"),
                        SizedBox(height: 3,),
                        Text("Business Representative:"),
                        SizedBox(height: 3,),
                        Text("Ownership Type:"),
                        SizedBox(height: 3,),
                        Text("Is Business Permit:"),
                        SizedBox(height: 3,),
                        Text("Business Permit Status:"),
                        SizedBox(height: 3,),
                        Text("Is Notice:"),
                        SizedBox(height: 3,),
                        Text("Notice Remarks:"),
                        SizedBox(height: 3,),
                        Text("Busienss Status:"),
                        SizedBox(height: 3,),
                        Text("Payment Type:"),
                        SizedBox(height: 3,),
                        Text("In Active Remarks:"),
                        SizedBox(height: 3,),
                        Text("In Active Reason:"),
                        SizedBox(height: 3,),
                        Text("FSIC:"),
                        SizedBox(height: 3,),
                        Text("FSIC Number:"),
                        SizedBox(height: 3,),
                        Text("Capitalization Amount:"),
                        SizedBox(height: 3,),
                        Text("Application Status:"),
                        SizedBox(height: 3,),
                        Text("Total Employees:"),
                        SizedBox(height: 3,),
                        Text("Total Male:"),
                        SizedBox(height: 3,),
                        Text("Total Female:"),
                        SizedBox(height: 3,),
                        Text("Location Status:"),
                        SizedBox(height: 3,),
                        Text("Location Rental Amount:"),
                        SizedBox(height: 3,),
                        Text("Lessor Name:"),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,0,0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Text("${this.widget.busdata.business_name}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.bar_name}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.purok}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.stall_no}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.business_owner_name}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.business_owner_number}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.business_representative}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.ownership_type}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.is_business_permit}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.business_permit_status}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.is_notice}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.notice_remarks}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.business_status}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.payment_type}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.inactive_remarks}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.inactive_reason}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.fsic}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.fsic_number}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.capitalization_amount}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.application_status}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.total_employees}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.total_male}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.total_female}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.location_status}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.location_rental_amount}"),
                          SizedBox(height: 3,),
                          Text("${this.widget.busdata.lessor_name}"),



                        ],
                      ),
                    )
                  ],
                ),
              ),
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
