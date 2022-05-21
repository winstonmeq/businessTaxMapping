import 'package:businesstaxmap/models/business.dart';
import 'package:businesstaxmap/screen/businessDetails.dart';
import 'package:businesstaxmap/screen/getBusiness.dart';
import 'package:businesstaxmap/screen/search.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';



class imageView extends StatefulWidget {
  final Business busdata;
  final String imgurl;
  imageView(this.busdata, this.imgurl);
  // const imageView({Key key}) : super(key: key);

  @override
  _imageViewState createState() => _imageViewState();
}

class _imageViewState extends State<imageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => busDetails(this.widget.busdata)),
          // );
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Image View"),
      ),
      body: Container(
         child: CachedNetworkImage(
            imageUrl: "${this.widget.imgurl}",
            imageBuilder: (context, imageProvider) => PhotoView(
              backgroundDecoration: BoxDecoration(color: Colors.white),
              imageProvider: imageProvider,
            ),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.image_sharp),
        ),
      ),
    );
  }
}
