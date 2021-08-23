import 'dart:convert';

import 'package:businesstaxmap/models/category.dart';
import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:businesstaxmap/services/categoryservices.dart';
import 'package:businesstaxmap/screen/lineBus.dart';
import 'package:flutter/material.dart';



class AddLineBus extends StatefulWidget {
  final int busId;
  final String busName;
  AddLineBus(this.busId, this.busName);

  // const lineBusiness({Key key}) : super(key: key);


  @override
  _AddLineBusState createState() => _AddLineBusState();
}

class _AddLineBusState extends State<AddLineBus> {


  bool isLoading = true;





  List<bool> checkbool = [];

  List<Category> arrayCat;


  _getCategory() async {
    try {
      arrayCat = <Category>[];
      var _categoryServices = CategoryServices();
      var registeredUser = await _categoryServices.getCategory();
      var _list = json.decode(registeredUser.body);
      print(_list);

      _list.forEach((data){
        var cat = Category();

        cat.id = data['id'];
        cat.category_name = data['category_name'];
        cat.is_pushed = data['is_pushed'];

        setState(() {
          arrayCat.add(cat);
          checkbool.add(false);
        });

      });

    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      delTable();
      isLoading = false;
    });
  }



  _getSQLData() async {
    try{
      var _businessServices = BusinessServices();
      //listlinebus = <LineBusiness>[];
      var sqlresponse = await _businessServices.getSQLdata();
      print("from sql");

      if(sqlresponse != null) {
        sqlresponse.forEach((data) {
          var bil = LineBusiness();
          // bil.id = data['id'];
          bil.category = data['category'];
          bil.business = data['business'];
          bil.cat_name = data['cat_name'];
          //bil.is_pushed = data['is_pushed'];
          //bil.created_by = data['created_by'];

          setState(() {
            listlinebus.add(bil);
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

    listlinebus.forEach((ad) {
      var bdata = LineBusiness();
      // bdata.id = ad.id;
      bdata.category = ad.category;
      bdata.business = ad.business;
      bdata.cat_name = ad.cat_name;
      bdata.is_pushed = ad.is_pushed;
      bdata.created_by = ad.created_by;
      _lineBusSend(context, bdata);

    });

  }




  _lineBusSend(BuildContext context, LineBusiness linedata) async {
    try {
      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.sendLineBus(linedata);
      print("sending data");
      var _list = json.decode(registeredUser.body);

      print(_list);

    } catch (e) {
      print(e);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LineBus(this.widget.busId, this.widget.busName)),
    );
  }


  delTable() async{
    var _businessServices = BusinessServices();
    var result = await _businessServices.delSQLtable();
    print("delete table");
    // print(result);

  }




  BusinessServices busServices = BusinessServices();
  List<LineBusiness> listlinebus = [];

  ///save to ddata to sqllite
  _addToSQL(BuildContext context, LineBusiness data) async {
    var result = await busServices.addToDB(data);

    if (result > 0) {
      //  _showError(context, "complete download");
      print(result);

    }
  }




  @override
  void initState() {
    _getCategory();

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading:  IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LineBus(this.widget.busId, this.widget.busName)),
          );
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Category Business"),),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: arrayCat.length,
          itemBuilder: (context,index){
            Category cate = Category();

            return Container(
                child: Column(
                  children: [
                    InkWell(
                      child: ListTile(

                          leading: Checkbox(
                              focusColor: Colors.red,
                              value: checkbool[index],
                               onChanged: (bool val) {
                                setState(() {
                                //  checkbool[index] = !checkbool[index];

                                });
                              }),

                          title: Text("${arrayCat[index].category_name}"),
                          trailing: ElevatedButton(
                            onPressed: (){

                              var linebus = LineBusiness();
                              //linebus.id = 0; dile eh apil kay naa automatic nga id sa sql------------
                              linebus.business = this.widget.busId;
                              linebus.category = arrayCat[index].id;
                              linebus.cat_name = arrayCat[index].category_name;
                              linebus.is_pushed = true;
                              linebus.created_by = 1;
                                _addToSQL(context, linebus);


                              setState(() {
                                checkbool[index] = !checkbool[index];
                              });
                            },
                            child: Text("Add"),
                          )
                      ),
                    ),

                           ],
                )

            );}
      ),
      bottomNavigationBar:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Expanded(
              child:  ElevatedButton(onPressed: (){

                _getSQLData();



              }, child: Text("Save")),
            ),
          )

        ],

      )

    );


  }
}
