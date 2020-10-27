import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter_appavailability/flutter_appavailability.dart';


class ThreeD extends StatefulWidget {
  static const routeName = '/3d';

  @override
  _ThreeDState createState() => _ThreeDState();
}

class _ThreeDState extends State<ThreeD> {

  void _opend3D(){
    AppAvailability.launchApp("com.example.sarvesh").then((_) {
      print("App com.example.sarvesh launched!");
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("App com.example.sarvesh not found!")
      ));
      print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    _opend3D();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
      ),
    );
  }
}

