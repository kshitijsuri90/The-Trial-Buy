import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myntra_clone/body_measurement/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


Future _showcontent(String size,BuildContext context) {
  showDialog(
    context: context, barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Size'),
        content: new SingleChildScrollView(
          child: new ListBody(
            children: [
              new Text('Your size is $size.'),
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

Future createBodyMeasurement(String age,String height,String weight,BuildContext context ) async {
  var resBody={};
  resBody["age"]=age;
  resBody["height"]=height;
  resBody["weight"]=weight;
  String str=json.encode(resBody);
  print(str);
  final http.Response response = await http.post(
    'https://d5b0c511242b.ngrok.io/predict',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: str,
  );

  if (response.statusCode == 200) {
    print(response.body);
    _showcontent(response.body, context);
  } else {
    throw Exception('Failed to create album.');
  }
}