import 'package:businesstaxmap/models/owner.dart';
import 'package:flutter/material.dart';

import 'editOwner.dart';

class OwnerDetails extends StatefulWidget {
  final Owner _ownerdata;

  OwnerDetails(this._ownerdata);
  @override
  _OwnerDetailsState createState() => _OwnerDetailsState();
}

class _OwnerDetailsState extends State<OwnerDetails> {

  String birth_date;

  changetext(){

    String split1 = this.widget._ownerdata.birth_date;

    setState(() {

      final split2 = split1.split('T');
      final Map<int, String> values = {
        for (int i = 0; i < split2.length; i++)
          i: split2[i]
      };
      print(values);
      birth_date = values[0];

    });

  }

  @override
  void initState() {
    changetext();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Owner Details"),
      ),
      body: ListView(
        children: [

       Column(
          children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Text(
                  "Owner Code: ${this.widget._ownerdata.owner_code.toString()}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        Center(
          child: new Container(
              decoration: new BoxDecoration(
                color: Colors.lightGreen,
                // gradient: new LinearGradient(
                //   colors: [Colors.red, Colors.cyan],
                // ),
              ),
              child: Icon(Icons.person,size: 100,)

          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 5, 1),
          child: Text(
            "${this.widget._ownerdata.first_name} ${this.widget._ownerdata.middle_name} ${this.widget._ownerdata.last_name} ${this.widget._ownerdata.extension}",
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text("Name:"),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 1),
          child: Text(
            "${this.widget._ownerdata.address}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text("Address"),
        SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 1),
          child: Text(
            "${birth_date}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text("Birth Date"),
        SizedBox(
          height: 20,
        ),

        Row(
          children: [
            Expanded(flex: 1, child: Center(child: Text("Gender"))),
            Expanded(flex: 1, child: Center(child: Text("Country"))),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "${this.widget._ownerdata.gender}",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),

            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "${this.widget._ownerdata.nationality}",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(flex: 1, child: Center(child: Text("Contact No"))),
            Expanded(flex: 1, child: Center(child: Text("Email Add"))),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "${this.widget._ownerdata.contact_no}",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),

            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    "${this.widget._ownerdata.email}",
                    style:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),



          ],
        ),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => editOwner(this.widget._ownerdata)),
            );
          },
            child: Text("Edit Data"),)

        ],
      ),
    );
  }
}
