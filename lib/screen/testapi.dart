import 'package:businesstaxmap/models/barangay.dart';
import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/services/business_services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';


class TestApi extends StatefulWidget {
  const TestApi({Key key}) : super(key: key);

  @override
  _TestApiState createState() => _TestApiState();
}

class _TestApiState extends State<TestApi> {

  List<Business> businessArray;
  BusinessServices _businessServices = BusinessServices();
  List<Barangay>  barangayList = [];

  _testapi() async {

    var response = await _businessServices.getBarangay();
    var _list = json.decode(response.body);
    print(_list);

    // for(var u in _list){
    //   Barangay bar = Barangay();
    //   bar.id = u['id'];
    //   bar.barangay_name = u['barangay_name'];
    //   barangayList.add(bar);
    // }

    _list.forEach((data){
      var bar = Barangay();

      bar.id = data['id'];
      bar.barangay_name = data['barangay_name'];

      setState(() {
        barangayList.add(bar);
      });
    });


  }

  _barangaySend(context, Barangay barangaydata) async {
    try {
      var _businessServices = BusinessServices();
      var registeredUser = await _businessServices.sendBarangay(barangaydata);
      var _list = json.decode(registeredUser.body);
      print(_list);
      if (_list['url'] != null) {
        print('data save');
      } else {
        print('unable to connect');
      }
    } catch (e) {
      print(e.toString());
    }
  }


  final barangay_name = TextEditingController();


  @override
  void initState() {
    _testapi();
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test Api'),
      ),
      body: ListView.builder(
        itemCount: barangayList.length,
          itemBuilder: (context,i){
          return Card(
            child: InkWell(
              child: Column(
                children: [
                  Text("${barangayList[i].barangay_name}"),
                  SizedBox(
                    height: 10,
                  ),

                  ElevatedButton(
                    onPressed: (){

                      var bar = Barangay();

                      bar.barangay_name = "name4";
                      // bar.is_delete = 'false';

                      _barangaySend(context, bar);
                    },
                    child: Text('Send to save'),
                  ),
                ],
              ),
            ),

          );

          }
      )
    );
  }
}
