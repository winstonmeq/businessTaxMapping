
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/models/linebusiness.dart';

import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';

import 'AddLineBus.dart';



class LineBus extends StatefulWidget {
  final Business busdata;
  final int busId;
  final String busName;
  LineBus(this.busId,this.busName,this.busdata);
  //const LineBus({Key key}) : super(key: key);


  @override
  _LineBusState createState() => _LineBusState();
}

class _LineBusState extends State<LineBus> {




  List<LineBusiness> listlinebus = [];


  bool isLoading = true;

  _getLineBusSQL(int busId) async {
    try{
      var _businessServices = BusinessServices();
      var sqlresponse = await _businessServices.getLineBusByIdSQL(busId);
      print("get linebusdata from sql.. sa businessTable");
      print(sqlresponse);

      if(sqlresponse != '[]') {
          sqlresponse.forEach((data) {
            var bil = LineBusiness();

            bil.id = data['id'];
            bil.category = data['category'];
            bil.business = data['business'];
            bil.cat_name = data['cat_name'];
            bil.comment = data['comment'];
            bil.is_pushed = data['is_pushed'];
            bil.created_by = data['created_by'];

            setState(() {
              listlinebus.add(bil);
            });
          });

          setState(() {
            isLoading = false;
          });


      }else{

        print("null value");


        setState(() {
          isLoading = false;
        });



      }
    }catch(e){
      print(e);

      setState(() {
        isLoading = false;
      });
    }


  }


  _deleteLineBus(BuildContext context, int id) async {
    var _businessServices = BusinessServices();
    var sqlresponse = await _businessServices.delSQLdataById(id);
    print("get linebusdata from sql.. sa businessTable");
    print(sqlresponse);

    setState(() {
      listlinebus.clear();
      _getLineBusSQL(this.widget.busId);
      //  isLoading = false;


    });
  }






  @override
  void initState() {

   _getLineBusSQL(this.widget.busId);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("${this.widget.busName}"),
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
                    _deleteLineBus(context, item.id);
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
                      MaterialPageRoute(builder: (context) => AddLineBus(this.widget.busId,this.widget.busName,this.widget.busdata))).then((value) {
                              setState(() {
                                listlinebus.clear();
                                _getLineBusSQL(this.widget.busId);
                              });
                      });

                  }, child: Text("Add Line"),

                  ),
                ),

              ),

            ],),
          )
        ],
      )
    );

  }
}
