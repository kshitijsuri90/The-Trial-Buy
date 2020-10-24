import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/common_widgets/cached_image.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_myntra_clone/body_measurement/body_measurements.dart';
import 'package:flutter_myntra_clone/body_measurement/request.dart';


class ThreeD extends StatefulWidget {
  static const routeName = '/3d';

  @override
  _ThreeDState createState() => _ThreeDState();
}

class _ThreeDState extends State<ThreeD> {
  File _image1,_image2;
  String image1base64,image2base64;

  @override
  Widget build(BuildContext context) {

    Future getImage1() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      List<int> imageBytes = image.readAsBytesSync();
      print(imageBytes);
      String base64Image = base64Encode(imageBytes);
      image1base64=base64Image;
      setState(() {
        _image1 = image;
        print('Image1 base $base64Image');
      });
    }

    Future getImage2() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      List<int> imageBytes = image.readAsBytesSync();
      print(imageBytes);
      String base64Image = base64Encode(imageBytes);
      image2base64=base64Image;
      setState(() {
        _image2 = image;
        print('Image2 base $image2base64');
      });
    }

    Future uploadPic(BuildContext context) async{
      var resBody={};
      resBody["front"]="image1base64";
      resBody["side"]="image2base64";
      String str=json.encode(resBody);

      setState(() {
        print("Profile Picture uploaded");
        print(str);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Text("3D")
    );
  }
}

