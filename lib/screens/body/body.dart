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


class Body extends StatefulWidget {
  static const routeName = '/body';

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
      body: Builder(
        builder: (context) =>  Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children:<Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 180,
                          height: 180,
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image1!=null)?Image.file(
                              _image1,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage1();
                          },
                        ),
                      ),
                    ],
                ),
                SizedBox(
                  width: 20.0,
                ),

                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 180,
                          height: 180,
                          child: new SizedBox(
                            width: 180.0,
                            height: 180.0,
                            child: (_image2!=null)?Image.file(
                              _image2,
                              fit: BoxFit.fill,
                            ):Image.network(
                              "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage2();
                          },
                        ),
                      ),
                    ]
                  ),
                ]
              ),

              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  color: Color(0xff476cfb),
                  onPressed: () {
                    uploadPic(context);
                    createBodyMeasurement("title");
                  },
                  elevation: 4.0,
                  splashColor: Colors.blueGrey,
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

