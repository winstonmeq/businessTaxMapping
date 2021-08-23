import 'package:businesstaxmap/models/owner.dart';
import 'package:businesstaxmap/screen/OwnerDetails.dart';
import 'package:businesstaxmap/services/owner_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class GetOwner extends StatefulWidget {
  @override
  _GetOwnerState createState() => _GetOwnerState();
}


class _GetOwnerState extends State<GetOwner> {


  List<Owner> arrayOwner;
  OwnerServices _ownerServices = OwnerServices();

  _getOwner() async {
    try{
      arrayOwner = List<Owner>();
      var response = await _ownerServices.getOwner();
       var _list = json.decode(response.body);
      print(_list);
      _list.forEach((data) {
         var ow = Owner();
         ow.id = data['id'];
        ow.owner_code = data['owner_code'];
        if(data['last_name'] != null) {
          ow.last_name = data['last_name'];
        }else{
          ow.last_name = "lastname";
        }
         if(data['first_name'] != null) {
        ow.first_name = data['first_name'];
         }else{
           ow.first_name = "firstname";
         }

         if(data['middle_name'] != null) {
           ow.middle_name = data['middle_name'];
         }else{
           ow.middle_name = "middle_name";
         }

         if(data['extension'] != null) {
        ow.extension= data['extension'];
         }else{
           ow.extension = "ext";
         }

         ow.birth_date = data['birth_date'];

         if(data['gender'] != null) {
           ow.gender = data['gender'];
         }else{
           ow.gender = "gender";
         }

         if(data['nationality'] != null) {
         ow.nationality = data['nationality'];
         }else{
           ow.nationality = "nationality";
         }

         if(data['contact_no'] != null) {
         ow.contact_no = data['contact_no'];
         }else{
           ow.contact_no = "contactno";
         }

         if(data['photo'] != null) {
         ow.photo = data['photo'];
         }else{
           ow.photo = "myphoto";
         }

         if(data['address'] != null) {
         ow.address= data['address'];
         }else{
           ow.address = "address";
         }

         if(data['email'] != null) {
         ow.email = data['email'];
         }else{
           ow.email = "email";
         }

         if(data['update_by'] != null) {
         ow.update_by = data['update_by'];
         }else{
           ow.update_by = "updated";
         }

        setState(() {
          arrayOwner.add(ow);
        });
      });

    }catch(e){
      _showError(context, e.toString());
    }
  }

  @override
  void initState() {

  _getOwner();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Owner's"),
        actions: [
          FlatButton(onPressed: (){
            showSearch(context: context,
                delegate: DataSearch(
                    arrayOwner,
                  ));

          }, child: Icon(Icons.search)),
        ],
      ),
      body:ListView.builder(
        itemCount: arrayOwner.length,
        itemBuilder: (context,ind){
          return Card(
              child: InkWell(
                onTap: (){
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      OwnerDetails(arrayOwner[ind])));
                },
                child: Column(
                  children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.black12,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8,8,1,8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Owner Code:"),
                              Text("Name:"),
                              Text("Gender:"),
                              Text("Country:"),
                              Text("Contact No.:"),
                              Text("Address:"),
                              Text("Email Add:")
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${arrayOwner[ind].owner_code.toString()}"),
                            Row(
                              children: [
                              Text("${arrayOwner[ind].first_name} ${arrayOwner[ind].middle_name} ${arrayOwner[ind].last_name} ${arrayOwner[ind].extension}",
                                maxLines: 2, overflow:TextOverflow.clip,
                                style: TextStyle(fontWeight: FontWeight.bold),),
                            ],),

                            Text(arrayOwner[ind].gender),
                            Text(arrayOwner[ind].nationality),
                            Text(arrayOwner[ind].contact_no),
                            Text(arrayOwner[ind].address),
                            Text(arrayOwner[ind].email),
                          ],

                        ),
                      ),

                    ],
                  ),


                  ],
                ),
              )
          );
        }),
    );
  }


  _showError(context, String msg) {
    setState(() {
      Navigator.pop(context);
    });
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.red),
                ),
              ],
            ),
          );
        });
  }


}





class DataSearch extends SearchDelegate{
  DataSearch(this.listProduct);
  final List<Owner> listProduct;



  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear),onPressed: (){
      query = "";
    },)];
    // TODO: implement buildActions
    // throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    final searchList = query.isEmpty ? listProduct : listProduct.where((
        element) => element.last_name.toLowerCase().contains(query)).toList();

    return searchList.isEmpty ? Text("search not found...") : ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context,index){
          Owner prd = searchList[index];
          return Card(
            child: ListTile(
              onTap: (){
                showResults(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    OwnerDetails(searchList[index])));

              },
              leading: Image.network(prd.photo),
              title: Text('${prd.first_name} ${prd.last_name}'),
              subtitle: Text('${prd.address}'),

            ),
          );
        }

    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final searchList = query.isEmpty ? listProduct : listProduct.where((
        element) => element.last_name.toLowerCase().contains(query)).toList();

    return searchList.isEmpty ? Text(" Search not found..."): ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context,index){
          Owner prd = searchList[index];
          return ListTile(
            onTap: (){
              showResults(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  OwnerDetails(searchList[index])));
            },
            //leading: Image.network(prd.photo),
            title: Text('${prd.first_name} ${prd.last_name}'),
            subtitle: Text("${prd.address}"),

          );
        }

    );

    // throw UnimplementedError();
  }

}





