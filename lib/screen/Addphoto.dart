import 'package:flutter/material.dart';

import '../landingpage.dart';
import 'addphoto1.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({Key key}) : super(key: key);

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Add Photo"),
        automaticallyImplyLeading: false,
        leading:  IconButton(onPressed: (){
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => LandingPage()),
          // );
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),

      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text("Business Permit Picture"),
                trailing: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => UploadImageDemo()),
                    );

                  }
                  ,child: Text("Camera"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text("Owner's Picture"),
                trailing: ElevatedButton(
                  onPressed: (){}
                  ,child: Text("Camera"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text("Owner's Signature Picture"),
                trailing: ElevatedButton(
                  onPressed: (){}
                  ,child: Text("Camera"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text("Goods Services Picture"),
                trailing: ElevatedButton(
                  onPressed: (){}
                  ,child: Text("Camera"),
                ),
              ),
            ),
          ), Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text("Picture 1"),
                trailing: ElevatedButton(
                  onPressed: (){}
                  ,child: Text("Camera"),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text("Picture 2"),
                trailing: ElevatedButton(
                  onPressed: (){}
                  ,child: Text("Camera"),
                ),
              ),
            ),
          ),


        ],

      ),
        bottomNavigationBar:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Expanded(
                child:  ElevatedButton(onPressed: (){

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );

                }, child: Text("Home")),
              ),
            )

          ],

        )

    );
  }


}
