import 'dart:convert';
import 'dart:io';
import 'package:businesstaxmap/landingpage.dart';
import 'package:flutter/material.dart';
import 'package:businesstaxmap/models/owner.dart';
import 'package:businesstaxmap/services/owner_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class OwnerScreen extends StatefulWidget {
  @override
  _OwnerScreenState createState() => _OwnerScreenState();
}



class _OwnerScreenState extends State<OwnerScreen> {


  List<String> _country = [

    'PHILIPPINES',
    'AFGHANISTAN',
    'ALBANIA',
    'ALGERIA',
    'ANDORRA',
    'ANGOLA',
    'ARGENTINA',
    'ARMENIA',
    'AUSTRALIA',
    'AUSTRIA',
    'AZERBAIJAN',
    'BAHAMAS',
    'BANGLADESH',
    'BARDABOS',
    'BELARUS',
    'BELGIUM',
    'BENIN',
    'BHUTAN',
    'BOLIVIA',
    'BOSNIA',
    'BRAZIL',
    'BRITAIN',
    'BRUNEI',
    'BULGARIA',
    'BURMA',
    'CAMBODIA',
    'CAMEROON',
    'CANADA',
    'CHAD',
    'CHILE',
    'CHINA',
    'COLOMBIA',
    'CONGO',
    'CROATIA',
    'CUBA',
    'CYPRUS',
    'CZECH REPUBLIC',
    'DENMARK',
    'DOMINICA',
    'ECUADOR',
    'EGYPT',
    'EL SALVADOR',
    'ENGLAND',
    'ERITREA',
    'ESTONIA',
    'ETHIOPIA',
    'FIJI',
    'FINLAND',
    'FRANCE',
    'GABON',
    'GAMBIA',
    'GEORGIA',
    'GERMANY',
    'GHANA',
    'GREECE',
    'GRENADA',
    'GUATEMALA',
    'GUINEA',
    'GUYANA',
    'HAITI',
    'HOLLAND',
    'HONDURAS',
    'HUNGARY',
    'ICELAND',
    'INDIA',
    'INDONESIA',
    'IRAN',
    'IRAQ',
    'IRELAND',
    'ISAEL',
    'ITALY',
    'JAMAICA',
    'JAPAN',
    'JORDAN',
    'KAZAKHSTAN',
    'KENYA',
    'KOREA',
    'KUWAIT',
    'LAOS',
    'LATVIA',
    'LEBANON',
    'LIBERIA',
    'LIBYA',
    'LIECHTENSEIN',
    'LITHUANIA',
    'LUXEMBOURG',
    'MACEDONIA',
    'MADAGASCAR',
    'MALAWI',
    'MALAYSIA',
    'MALDIVES',
    'MALI',
    'MALTA',
    'MAURITANIA',
    'MAURITIUS',
    'MEXICO',
    'MOLDOVA',
    'MONACO',
    'MONGOLIA',
    'MONTENEGRO',
    'MOROCCO',
    'MOZAMBIQUE',
    'NAMIBIA',
    'NEPAL',
    'NICARAGUA',
    'NIGERIA',
    'NORWAY',
    'PAKITAN',
    'PANAMA',
    'PARAGUAY',
    'PERU',
    'POLAND',
    'PORTUGAL',
    'QATAR',
    'ROMANIA',
    'RUSSIA',
    'RWANDA',
    'SAUDI ARABIA',
    'SCOTLAND',
    'SENEGAL',
    'SERBIA',
    'SINGAPORE',
    'SLOVAKIA',
    'SLOVENIA',
    'SOMALIA',
    'SPAIN',
    'SRI LANKA',
    'SUDAN',
    'SWAZILAND',
    'SWEDEN',
    'SWITZERLAND',
    'SYRIA',
    'TAIWAN',
    'TAJIKISTAN',
    'THAILAND',
    'TOGO',
    'TRINIDAD',
    'Tunisia',
    'TURKEY',
    'UGANDA',
    'UKRAINE',
    'UNITED KINGDOM',
    'UNITED STATES',
    'URUGUAY',
    'UZBEKISTAN',
    'VENEZUELA',
    'VIETNAM',
    'WALES',
    'YEMEN',
    'YUGOSLAVIA',
    'ZAMBIA',
    'ZIMBABWE'
  ];


  final owner_code = TextEditingController();
  final last_name = TextEditingController();
  final first_name = TextEditingController();
  final middle_name = TextEditingController();
  final extension = TextEditingController();
  final birth_date = TextEditingController();
  final gender = TextEditingController();
  final nationality = TextEditingController();
  final contact_no = TextEditingController();
  final photo = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();
  final update_by = TextEditingController();
  final imgfilepath = TextEditingController();

  String birthDateInString;
  DateTime birthDate;
  bool isDateSelected = false;

  PickedFile imageFile;
  String base64Image;
  File tmpFile;

  List<String> _gender = ['FEMALE', 'MALE']; // Option 2



  Future getImage() async {
    PickedFile pickedImage = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 10 );
    return pickedImage;
  }



  _OwnerSend(context, Owner owndata) async {
    try {
      var _ownerServices = OwnerServices();
      var registeredUser = await _ownerServices.ownerSend(owndata);

      var _list = json.decode(registeredUser.body);
      print(_list);
      if (_list['url'] != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingPage()),
        );;
       } else {
        _showError(context, "Unable to connect");
       }
    } catch (e) {
      _showError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Owner Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: owner_code,
              decoration: InputDecoration(
                labelText: 'Owner Code',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: last_name,
              decoration: InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: first_name,
              decoration: InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: middle_name,
              decoration: InputDecoration(
                labelText: 'Middle Name',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: extension,
              decoration: InputDecoration(
                labelText: 'Extension',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    controller: birth_date,
                    decoration: InputDecoration(
                      labelText: "Birthday",
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                  child: GestureDetector(
                      child: Row(
                        children: [
                          Text("Calendar"),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,1,8,1),
                            child: Icon(Icons.calendar_today),
                          ),
                        ],
                      ),
                      onTap: () async {
                        final datePick = await showDatePicker(
                            context: context,
                            initialDate: new DateTime.now(),
                            firstDate: new DateTime(1900),
                            lastDate: new DateTime(2100));
                        if (datePick != null && datePick != birthDate) {
                          setState(() {
                            birthDate = datePick;
                            isDateSelected = true;                   // put it here
                            birthDateInString ="${birthDate.year}-${birthDate.month}-${birthDate.day}T00:00:00"; // 08/14/2019
                            birth_date.text = "${birthDate.year}-${birthDate.month}-${birthDate.day}";
                          });
                        }
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
           Row(
             children: [
               Expanded(
                 child: TextField(
                   style: TextStyle(fontSize: 20),
                   keyboardType: TextInputType.visiblePassword,
                   controller: gender,
                   decoration: InputDecoration(
                     labelText: 'Gender',
                     labelStyle: TextStyle(fontSize: 12),
                     contentPadding: EdgeInsets.all(5),
                     focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.red, width: 1.0),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.black, width: 1.0),
                     ),
                   ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(15,0,10,0),
                 child: DropdownButton(
                   hint: Text("Select"), // Not necessary for Option 1
                   onChanged: (value) {
                     setState(() {
                       gender.text = value;
                     });
                   },
                   items: _gender.map((result) {
                     return DropdownMenuItem(
                       child: Container(width:100,child: new Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                       value: result,
                     );
                   }).toList(),
                 ),
               ),
             ],
           ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    controller: nationality,
                    decoration: InputDecoration(
                      labelText: 'Nationality',
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(15,0,10,0),
                  child: DropdownButton(
                    hint: Text("Select"), // Not necessary for Option 1
                    onChanged: (value) {
                      setState(() {
                        nationality.text = value;
                      });
                    },
                    items: _country.map((result) {
                      return DropdownMenuItem(
                        child: Container(width:100,child: Text(result,style: TextStyle(fontSize: 12,),overflow:TextOverflow.ellipsis,)),
                        value: result,
                      );
                    }).toList(),
                  ),
                ),



              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              controller: contact_no,
              decoration: InputDecoration(
                labelText: 'Contact No',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [

                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.visiblePassword,
                    controller: imgfilepath,
                    decoration: InputDecoration(
                      labelText: "File Name",
                      labelStyle: TextStyle(fontSize: 12),
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5,1,5,1),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: imageFile == null
                                ? AssetImage('assets/images/folder.png')
                                : FileImage(File(imageFile.path)),
                            fit: BoxFit.contain)),
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    final tmpFile = await getImage();

                    setState(() {
                      imageFile = tmpFile;
                      imgfilepath.text = basename(imageFile.path).toString();
                    });
                  },
                  child: Text('Camera'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: address,
              decoration: InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.visiblePassword,
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email Add',
                labelStyle: TextStyle(fontSize: 12),
                contentPadding: EdgeInsets.all(5),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            ButtonTheme(
              minWidth: 160,
              child: RaisedButton(
                onPressed: () {
                  _showProgress(context);

                  var ownerdata = Owner();
                  ownerdata.owner_code = int.parse(owner_code.text);
                  ownerdata.first_name = first_name.text;
                  ownerdata.last_name = last_name.text;
                  ownerdata.middle_name = middle_name.text;
                  ownerdata.extension = extension.text;
                  ownerdata.birth_date = birthDateInString;
                  ownerdata.gender = gender.text;
                  ownerdata.nationality = nationality.text;
                  ownerdata.contact_no = contact_no.text;
                  ownerdata.photo = imgfilepath.text;
                  ownerdata.address = address.text;
                  ownerdata.email = email.text;
                  ownerdata.update_by = "admin";

                  _OwnerSend(context, ownerdata);

                },
                color: Colors.orangeAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save, size:20,),
                      Text(
                        "SAVE DATA",
                        style: TextStyle(fontSize: 16),
                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  _showProgress(context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  _showCorrect(context, String msg) {
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
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ],
            ),
          );
        });
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
