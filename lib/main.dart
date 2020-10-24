import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/screens/home_screen.dart';
import 'package:flutter_myntra_clone/screens/login/login.dart';
import 'package:flutter_myntra_clone/screens/login/otp.dart';
import 'package:flutter_myntra_clone/screens/products/product_details.dart';
import 'package:flutter_myntra_clone/screens/products/product_list.dart';
import 'package:flutter_myntra_clone/screens/body/body.dart';
import 'package:flutter_myntra_clone/screens/body/2d.dart';
import 'package:flutter_myntra_clone/screens/body/3d.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Myntra',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        accentColor: Colors.white,
      ),
      home: Login(),
      routes: {
        Login.routeName: (ctx) => Login(),
        Otp.routeName: (ctx) => Otp(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
        ProductList.routeName: (ctx) => ProductList(),
        ProductDetails.routeName: (ctx) => ProductDetails(),
        Body.routeName:(ctx) => Body(),
        TwoD.routeName:(ctx) => TwoD(),
        ThreeD.routeName:(ctx) => ThreeD(),
      },
    );
  }
}
