import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myntra_clone/common_widgets/cached_image.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_myntra_clone/body_measurement/body_measurements.dart';
import 'package:flutter_myntra_clone/body_measurement/request.dart';


class TwoD extends StatefulWidget {
  static const routeName = '/2d';

  @override
  _TwoDState createState() => _TwoDState();
}

class _TwoDState extends State<TwoD> {
  File _image1,_image2;
  String image1base64,image2base64;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    var padding = MediaQuery.of(context).padding;
    double height1 = height - 70;

    void _showcontent() {
      showDialog(
        context: context, barrierDismissible: false, // user must tap button!

        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('You clicked on'),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: [
                  new Text('Please take body measurement first.'),
                ],
              ),
            ),
            actions: [
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    SystemNavigator.pop();
                  }
                },
              ),
            ],
          );
        },
      );
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
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width,
                    height: height1,
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
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                  color: Color(0xff476cfb),
                  onPressed: () {
                    _showcontent();
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

