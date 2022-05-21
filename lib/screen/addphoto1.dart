import 'package:businesstaxmap/screen/Addphoto.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadImageDemo extends StatefulWidget {
  UploadImageDemo() : super();

  final String title = "Capture Image";

  @override
  UploadImageDemoState createState() => UploadImageDemoState();
}

class UploadImageDemoState extends State<UploadImageDemo> {
  //
  static final String uploadEndPoint = 'http://192.168.43.80/meedo/public/image_upload.php';


  Future<File> file;
  ImagePicker picker = ImagePicker();

PickedFile imageFile,image2;
  String status = '';
  String base64Image;
  String _path;
  String finalname;
  File tmpFile,file2;
  String errMessage = 'Error Uploading Image';

  Future chooseImage() async {
         XFile fil = await picker.pickImage(source: ImageSource.camera);
       return PickedFile(fil.path);
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  upload(String fileName) {
    http.post(Uri.parse(uploadEndPoint), body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }



  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }

    String fileName = tmpFile.path.split('/').last;

    upload(fileName);
    setState(() {
     // Navigator.of(context).pop();
    });
  }

  Camera() async{
    imageFile = await chooseImage();
    setState(() {
      tmpFile = File(imageFile.path);
    });
  }



  @override
  void initState() {
  Camera();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capture Image"),
        automaticallyImplyLeading: false,
        leading:  IconButton(onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddPhoto()),
          );
        }, icon: Icon(Icons.arrow_back)),

      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              //shape: BoxShape.rectangle,
                image: DecorationImage(
                    image: tmpFile == null
                        ? AssetImage('')
                        : FileImage(File(tmpFile.path)),
                    fit: BoxFit.cover))

          ),),
          Expanded(
            flex: 1,
              child: GestureDetector(
                onTap: () {
                 Camera();

                },
                child: new Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 2, color: Colors.red)),
                      child: Icon(
                        Icons.camera_enhance,
                        color: Colors.black,
                      ),
                    )),
              ),
          )


        ],
      ),
        bottomNavigationBar:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Expanded(
                child:  ElevatedButton(onPressed: startUpload, child: Text("Save")),
              ),
            )

          ],

        )
    );
  }
}