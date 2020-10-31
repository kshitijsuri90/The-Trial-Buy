import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myntra_clone/body_measurement/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:giffy_dialog/giffy_dialog.dart';


String url="http://192.168.0.100:8000/";

Future create2d(double height,double width,String image,BuildContext context ) async {
  //------------------imageupload-------------------
  var resBody={};
  resBody['image']=image;
  String str=json.encode(resBody);
  print(str);
  final http.Response response = await http.post(
    url+'/imageUpload',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: str,
  );

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to create album.');
  }

//---------------------------------------setMask----------------

  var resBody1={};
  resBody1['flag']=0;
  resBody1['topX']=0;
  resBody1['topY']=height;
  resBody1['width']=width;
  resBody1['height']=height;
  var list=List();
  var newone={};
  newone['x']=height/2;
  newone['y']=width/2;
  list.add(newone);
  resBody1['foreground']=list;
  resBody1['background']=list;
  String str1=json.encode(resBody1);
  print(str1);
  final http.Response response1 = await http.post(
    url+'/setMask',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: str1,
  );

  if (response1.statusCode == 200) {
    print(response1.body);
  } else {
    throw Exception('Failed to create album.');
  }


  //--------------------upprocess----------------------
  var resBody2={};
  String str2=json.encode(resBody2);
  print(str2);
  final http.Response response2 = await http.post(
    url+'/upProcess',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: str2,
  );

  if (response2.statusCode == 200) {
    print(response2.body);
  } else {
    throw Exception('Failed to create album.');
  }

//------------------------fitup----------------
  var resBody3={};
  resBody3['catId']=0;
  String str3=json.encode(resBody3);
  print(str3);
  final http.Response response3 = await http.post(
    url+'/fitUp',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: str3,
  );

  if (response3.statusCode == 200) {
    print(response3.body);
  } else {
    throw Exception('Failed to create album.');
  }
}