import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key key, this.title, this.onPressed}) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(12),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      color: Color.fromRGBO(255,63,108, 1),
      onPressed: onPressed,
    );
  }
}
