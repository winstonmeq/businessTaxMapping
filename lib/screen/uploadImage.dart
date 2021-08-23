import 'dart:convert';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';



class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {



  // XFile _image;
  //
  // Future _getImage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = image;
  //   });
  // }


  // Future getImage() async {
  //   PickedFile pickedImage = await ImagePicker().getImage(
  //       source:  ImageSource.gallery,
  //       imageQuality: 50);
  //   return pickedImage;  }

  Future getImage() async {
    File _image;


    var _pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 50,
        maxHeight: 50,
        imageQuality: 50,
        preferredCameraDevice:CameraDevice.rear
    );

    setState(() {
      _image = File(_pickedFile.path);
    });


    _upload(_image);

  }

  void _upload(File file) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
       "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = new Dio();

    print(file.path);
    print(fileName);

    dio.post("https://btm-101.herokuapp.com/api/v1/media/owner_pic", data: data)
        .then((response) => print(response))
        .catchError((error) => print(error));
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
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //         image: imageFile == null
                //             ? AssetImage('assets/images/midsayaplogo.gif')
                //             : FileImage(File(imageFile.path)),
                //         fit: BoxFit.contain)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () async {
                      getImage();
                  },
                    child: Text('Choose Image'),
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(onPressed: () async {

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