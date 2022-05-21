import 'package:businesstaxmap/landingpage.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/screen/editBusiness2.dart';
import 'package:businesstaxmap/screen/lineBus.dart';
import 'package:businesstaxmap/screen/businessDetails.dart';
import 'package:businesstaxmap/screen/search.dart';
import 'package:businesstaxmap/screen/testlinebus.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class GetBusiness extends StatefulWidget {
  @override
  _GetBusiness createState() => _GetBusiness();
}


class _GetBusiness extends State<GetBusiness> {


  List<Business> businessArray = [];
  bool isLoading = true;

  _getBusiness() async {
    try{
      BusinessServices _businessServices = BusinessServices();
      var response = await _businessServices.getBusiness();
      var _list = json.decode(response.body);
      print(_list);


      _list['results'].forEach((data) {
        var bus = Business();
          bus.id = data['id'];
          bus.qr_code = data['qr_code'];
          bus.qrcode = data['qrcode'];
          bus.business_name = data['business_name'];
          bus.barangay = data['barangay'];
           bus.bar_name = data['bar_name'];
          bus.purok= data['purok'];
          bus.stall_no = data['stall_no'];
          bus.gps_longitude = data['gps_longitude'];
          bus.gps_latitude = data['gps_latitude'];
          bus.gps_altitud = data['gps_altitud'];
          bus.gps_accuracy = data['gps_accuracy'];
          bus.owner_picture = data['owner_picture'];
          bus.goods_services_picture = data['goods_services_picture'];
          bus.business_permit_picture = data['business_permit_picture'];
          bus.business_owner_name = data['business_owner_name'];
          bus.business_owner_number = data['business_owner_number'];
          bus.business_representative = data['business_representative'];
          bus.owner_gender = data['owner_gender'];
          bus.ownership_type = data['ownership_type'];
          bus.is_business_permit = data['is_business_permit'];
          bus.business_permit_status = data['business_permit_status'];
          bus.is_notice = data['is_notice'];
          bus.business_status = data['business_status'];
          bus.payment_type = data['payment_type'];
          bus.inactive_remarks = data['inactive_remarks'];
          bus.inactive_reason = data['inactive_reason'];
          bus.fsic = data['fsic'];
          bus.fsic_number = data['fsic_number'];
          bus.capitalization_amount = data['capitalization_amount'];
          bus.gross_sale_amount = data['gross_sale_amount'];
          bus.total_employees = data['total_employees'];
          bus.application_status = data['application_status'];
          bus.total_male = data['total_male'];
          bus.total_female = data['total_female'];
          bus.location_status = data['location_status'];
          bus.location_rental_amount = data['location_rental_amount'];
          bus.lessor_name = data['lessor_name'];
          bus.owner_signature = data['owner_signature'];
          bus.collector_signature = data['collector_signature'];
          bus.collector_designation = data['collector_designation'];
          bus.picture1 = data['picture1'];
          bus.picture2 = data['picture2'];
          bus.picture3 = data['picture3'];
          bus.submitted_from = data['submitted_from'];
          bus.qrcode_url = data['qrcode_url'];

          //businessArray.add(bus);
        setState(() {
          _savetoSQL(context, bus);
        });


      });

    }catch(e){
      print(e);
      setState(() {
        isLoading = false;
      });

    }

    setState(() {
      isLoading = false;
    });

  }

  _savetoSQL(BuildContext context, Business busdata) async {

    BusinessServices _businessServices = BusinessServices();
    var sqlresponse = await _businessServices.addBusinessSQL(busdata);

    print(sqlresponse);


  }





  @override
  void initState() {

    if(businessArray.length == 0){
      print("mag load sang data kay 0 ang value");
      _getBusiness();
    }else {
      print("naa sulod nga data");
    }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        leading:  IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LandingPage()),
          );
        }, icon: Icon(Icons.arrow_back)),
        title: Text("List of Business"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_sharp),
           // tooltip: 'Search',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchBus()),
              );
              // showSearch(context: context,
              //     delegate: DataSearch(
              //         businessArray,
              //        ));
            },
          ),
        ],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : ListView.builder(
          itemCount: businessArray.length,
          itemBuilder: (context,index){
            return Card(
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditBusiness2(businessArray[index])),
                  );
                },

               child: ListTile(

                 leading: (ElevatedButton(
                     onPressed: (){
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => busDetails(businessArray[index])),

                       );
                     },child: Text("View"),
                 )
                 ),
                 title: Text('${businessArray[index].business_name}'),
                 subtitle: Text('${businessArray[index].id}'),
                 // trailing: ElevatedButton(
                 //   onPressed: (){
                 //     Navigator.push(
                 //       context,
                 //       MaterialPageRoute(builder: (context) => LineBus(businessArray[index].id,businessArray[index].business_name)),
                 //     );
                 //   },child: Text("Line of Buss."),style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
                 // ),
               ),
              ),
            );

          }),
    );

  }




}

class DataSearch extends SearchDelegate{
  final List<Business> listbus;
 // final VoidCallback oneClick;
  DataSearch(this.listbus);


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

    final searchList = query.isEmpty ? listbus : listbus.where((
        element) => element.business_name.toLowerCase().contains(query)).toList();

    return searchList.isEmpty ? Text("search not found...") : ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context,index){
          Business bus = searchList[index];
          return Card(
            child: ListTile(
              onTap: (){
                showResults(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    busDetails(bus)));


              },
              //leading: Image.network(prd.photo),
              title: Text('${bus.business_name}'),
             // trailing: Text("P ${prd.price.toString()}",style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text('${bus.bar_name}'),

            ),
          );
        }

    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final searchList = query.isEmpty ? listbus : listbus.where((
        element) => element.business_name.toLowerCase().contains(query)).toList();

    return searchList.isEmpty ? Text(" Search not found..."): ListView.builder(
        itemCount: searchList.length,
        itemBuilder: (context,index){
          Business bus = searchList[index];
          return ListTile(
            onTap: (){
              showResults(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  busDetails(bus)));

            },
            //leading: Image.network(prd.photo),
            title: Text('${bus.business_name}'),
            // subtitle: Text("${prd.isAvailable}"),

          );
        }

    );

    // throw UnimplementedError();
  }

}

