import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {


  PickedFile imageFile;
  String base64Image;
  File tmpFile;
  String error = 'Error';
  String status = '';

  Future getImage() async {
    // ignore: deprecated_member_use
    PickedFile pickedImage = await ImagePicker().getImage(
        source:  ImageSource.gallery,
        imageQuality: 50);
    return pickedImage;  }




  setStatus(String message) {
    setState(() {
      status = message;
    });
  }




  upload(String fileName) {
    http.post(Uri.parse('http://finenut.in/demo/uploadData.php'), body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : error);
    }).catchError((error) {
      setStatus(error);
    });
  }

  
  uploadImg() {
    if (null == tmpFile) {
      setStatus(error);
      return;
    }

    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image/Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                    image: DecorationImage(
                        image: imageFile == null
                            ? AssetImage('assets/images/midsayaplogo.gif')
                            : FileImage(File(imageFile.path)),
                        fit: BoxFit.contain)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(onPressed: () async {
                    final tmpFile = await getImage();
                    setState(() {
                      imageFile = tmpFile;
                    });
                  },
                    child: Text('Choose Image'),
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(onPressed: () async {
                          uploadImg();
                  },
                    child: Text('Upload Image'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}