import 'package:businesstaxmap/models/business.dart';
import 'package:flutter/material.dart';

import 'editBusiness.dart';



class BusinessDetails extends StatefulWidget {
  final Business _busdata;
  BusinessDetails(this._busdata);
  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Details"),
      ),
      body: ListView(
        children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              children: [
                Expanded(flex:1,child: Container(color:Colors.black12,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Requirements",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ))),
              ],
            ),

            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,1,8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Business Code:"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Permit No."),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("DTI No:"),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.business_code.toString()}"),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.permit_no}"),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.dti_no}"),
                      // ),


                    ],

                  ),
                ),

              ],
            ),

            Row(
              children: [
                Expanded(flex:1,child: Container(color:Colors.black12,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Basic Information",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ))),
              ],
            ),

            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,1,8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Business Name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Ownership Type"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("capital"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Representative"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Employee No."),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Male"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Female"),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.business_name}",style: TextStyle(fontWeight: FontWeight.bold),),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.ownership_type}"),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.capital}"),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.representative}"),
                      // ),
                      //
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.employees_no}"),
                      // ),
                      //
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.employees_male}"),
                      // ),
                      //
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.employees_female}"),
                      // ),


                    ],

                  ),
                ),

              ],
            ),

            Row(
              children: [
                Expanded(flex:1,child: Container(color:Colors.black12,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Contact Information",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ))),
              ],
            ),

            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8,8,1,8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Mobile No."),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Email Add"),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Address"),
                        )
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.contact_no}"),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("${this.widget._busdata.email}"),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       Text("${this.widget._busdata.location2}, ${this.widget._busdata.location1}"),
                      //     ],),
                      // ),
                    ],

                  ),
                ),

              ],
            ),


          ],

        ),
      ],
      ), bottomNavigationBar: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        RaisedButton(onPressed: (){
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => EditBusiness(this.widget._busdata)),
          // );
        },
          child: Text("Edit Data"),)

      ],
    ),

    );
  }
}
