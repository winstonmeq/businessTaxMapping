import 'dart:convert';

import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';

import 'AddLineBus.dart';



class testLine extends StatefulWidget {
  final int busId;
  final String busName;
  testLine(this.busId,this.busName);
  //const LineBus({Key key}) : super(key: key);


  @override
  _testLineState createState() => _testLineState();
}

class _testLineState extends State<testLine> {




  List<LineBusiness> arrayLineBus = [];
  BusinessServices _businessServices = BusinessServices();



  _getLineBus() async {
    try{

      var webresponse = await _businessServices.getLineBus(this.widget.busId);
      var webdata = json.decode(webresponse.body);
      print("from server");
      print(webdata);

        webdata.forEach((data) {
          var line = LineBusiness();
          line.id = data['id'];
          line.category = data['category'];
          line.business = data['business'];
          line.comment = data['comment'];
          line.is_pushed = data['is_pushed'];
          line.cat_name = data['cat_name'];
          line.created_by = data['created_by'];

          setState(() {
            arrayLineBus.add(line);
          });
        });



    }catch(e){
       print(e);
    }
    print(arrayLineBus.length);
  }









  @override
  void initState() {

    _getLineBus();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("${this.widget.busName}"),),
        body: ListView.builder(
            itemCount: arrayLineBus.length,
            itemBuilder: (context,index){
              return Card(
                child: InkWell(
                  onTap: (){

                  },

                  child: ListTile(
                    title: Text('${arrayLineBus[index].cat_name}'),
                    subtitle: Text('${arrayLineBus[index].id}'),
                    trailing: ElevatedButton(
                      onPressed: (){

                      },child: Text("Line of Buss."),
                    ),
                  ),
                ),
              );

            }),
    );

  }
}
