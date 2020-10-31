import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myntra_clone/body_measurement/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:giffy_dialog/giffy_dialog.dart';


Future _showcontent(String size,BuildContext context) {

  showDialog(
    context: context, barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return NetworkGiffyDialog(
          image:Image.network("https://raw.githubusercontent.com/Prakash-sa/data/master/man_wearing_jacket.gif?token=AINA46VMS64HP7RRTKJERHK7UE2WC",
            fit: BoxFit.cover,
          ),
          title: Text('Size Estimator',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600)),
          description:Text('Your size is $size',
          textAlign: TextAlign.center,
          ),
          onOkButtonPressed: () {
            Navigator.of(context).pop();
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
        onCancelButtonPressed:() {
          Navigator.of(context).pop();
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          } else {
            SystemNavigator.pop();
          }
        },
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
    'https://c87ac0f6be11.ngrok.io/predict',
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