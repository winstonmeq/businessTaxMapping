
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/models/category.dart';
import 'package:businesstaxmap/models/linebusiness.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';

import 'lineBus.dart';



class AddLineBus extends StatefulWidget {

  final int busId;
  final String busName;
  final Business busdata;
  AddLineBus(this.busId, this.busName,this.busdata);

  // const lineBusiness({Key key}) : super(key: key);


  @override
  _AddLineBusState createState() => _AddLineBusState();
}

class _AddLineBusState extends State<AddLineBus> {


  bool isLoading = true;


  List<bool> checkbool = [];

  List<Category> categoryarray = [];

  _getCategoryTable() async {
    try{
      var _businessServices = BusinessServices();
      var sqlresponse = await _businessServices.getSQLcategoryTable();
      print("get category table from sqldb para eh add sa category array");
      print(sqlresponse);

      if(sqlresponse != null) {
        sqlresponse.forEach((data) {

          var cate = Category();
          cate.id = data['id'];
          cate.category_name = data['category_name'];

          setState(() {
            categoryarray.add(cate);
            checkbool.add(false);
          });


        });
      }//endif


              setState(() {
                isLoading = false;
              });



    }catch(e){

      print(e);

            setState(() {
              isLoading = false;
            });
    }

  print(categoryarray.length);

  }



  BusinessServices busServices = BusinessServices();

  List<LineBusiness> listlinebus = [];

  ///save to ddata to sqllite
  _addToLineBusSQL(BuildContext context, LineBusiness data) async {
    var result = await busServices.addToLineBus(data);

    if (result > 0) {
      //  _showError(context, "complete download");
      print(result);

    }
  }




  @override
  void initState() {
    _getCategoryTable();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
         title: Text("Category Business"),),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: categoryarray.length,
          itemBuilder: (context,index){

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

                          title: Text("${categoryarray[index].category_name}"),
                          trailing: ElevatedButton(
                            onPressed: (){

                              var linebus = LineBusiness();

                              linebus.business = this.widget.busId;
                              linebus.category = categoryarray[index].id;
                              linebus.comment = "Added on ${categoryarray[index].category_name}, ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
                              linebus.cat_name = categoryarray[index].category_name;
                              linebus.is_pushed = 'true';
                             linebus.created_by = 1;
                             _addToLineBusSQL(context, linebus);


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
      // bottomNavigationBar:Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Container(
      //       child: Expanded(
      //         child:  ElevatedButton(onPressed: (){
      //
      //         //  _getSQLData();
      //
      //
      //
      //         }, child: Text("Save")),
      //       ),
      //     )
      //
      //   ],
      //
      // )

    );


  }
}
