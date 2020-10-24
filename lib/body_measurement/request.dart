import 'package:flutter_myntra_clone/body_measurement/body_measurements.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<BodyMeasurement> createBodyMeasurement(String title) async {
  final http.Response response = await http.post(
    'https://jsonplaceholder.typicode.com/albums',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 201) {
    return BodyMeasurement.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}