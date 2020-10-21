import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

}