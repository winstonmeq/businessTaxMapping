import 'dart:convert';

import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:businesstaxmap/screen/Addphoto.dart';
import 'package:businesstaxmap/screen/businessDetails.dart';
import 'package:businesstaxmap/screen/AddLinesBus2.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';


class LineBus2 extends StatefulWidget {
  final Business busdata;
  final int busId;
  final String busName;
  LineBus2(this.busId,this.busName,this.busdata);
  //const LineBus({Key key}) : super(key: key);


  @override
  _LineBus2State createState() => _LineBus2State();
}

class _LineBus2State extends State<LineBus2> {




  List<LineBusiness> listlinebus = [];


  bool isLoading = true;



  ///mao ang tama nga code sa pag GET sang data sa server.. ayaw kalimut sang setting kay importante kaau nah
  ///kung kami kah GEt method.. tpos kuhaon nimu tanan nga data sang class

  _getLineBus() async {
    try{
      var _businessServices = BusinessServices();
      var webresponse = await _businessServices.getLineBus(this.widget.busId);
      var webdata = json.decode(webresponse.body);
      print("from server");
      print(webdata);

      if(webdata != null) {
        webdata.forEach((data) {

          var line = LineBusiness();
          line.id = data['id'];
          line.category = data['category'];
          line.business = data['business'];
          line.cat_name = data['cat_name'];
          line.is_pushed = data['is_pushed'].toString();
          line.created_by = data['created_by'];
          setState(() {
            listlinebus.add(line);
          });


        });


      }else{
        print("null value");
      }
    }catch(e){
      print(e);
      setState(() {
        isLoading = false;
      });
    }
    print(listlinebus.length);

    setState(() {
      isLoading = false;
    });

  }





  _deletelinebus(BuildContext context, int catId) async {
    try {

      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.delLineBus(catId);
      print("sending delete line business data");
      var _list = json.decode(registeredUser.body);

      print(_list);

    } catch (e) {
      print(e);
    }
    setState(() {
      listlinebus.clear();
      _getLineBus();
      //  isLoading = false;


    });

  }







  @override
  void initState() {
    //  _getSQLData();
    _getLineBus();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("${this.widget.busName}"),
          leading:  IconButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          }, icon: Icon(Icons.arrow_back)),



        ),
        body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Line of Business",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  )
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(40, 5, 5, 5),
              child: Column(children: listlinebus.map((item) => Card(
                //color: Colors.lime,
                child: new ListTile(
                  title: Text(item.cat_name),
                  trailing: ElevatedButton(
                    onPressed: (){
                      _deletelinebus(context,item.id);
                      setState(() {
                        isLoading = true;
                      });




                    },child: Text("Delete"),
                  ),
                ),
              )

              ).toList()),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  child: Expanded(
                    child:  ElevatedButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddLineBus2(this.widget.busId,this.widget.busName,this.widget.busdata)),
                      );

                    }, child: Text("Add Line"),

                    ),
                  ),

                ),
              ],),
            )
          ],
        ),

    );

  }
}
