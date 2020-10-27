import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myntra_clone/common_widgets/cached_image.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/common_widgets/primary_button.dart';
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
  String age,height,weight;

  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    ageController.addListener(_ageLatestValue);
    weightController.addListener(_weightLatestValue);
    heightController.addListener(_heightLatestValue);
  }

  _ageLatestValue(){
    print("age ${ageController.text}");
    age=ageController.text;
  }

  _weightLatestValue(){
    print("age ${weightController.text}");
    weight=weightController.text;
  }

  _heightLatestValue(){
    print("age ${heightController.text}");
    height=heightController.text;
  }

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
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget>[
                Row(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: ageController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: 'Age'
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child:
                            TextField(
                              controller: heightController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: 'Height'
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child:
                            TextField(
                              controller: weightController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  labelText: 'Weight'
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.left -
                            MediaQuery.of(context).padding.right) *
                            0.45,
                        child: ButtonTheme(
                          child: PrimaryButton(
                            title: 'SUBMIT',
                            onPressed: () => {

                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

