import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  const LinkButton({Key key, this.title, this.onPressed}) : super(key: key);
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(255,63,108, 1),
        ),
      ),
      padding: EdgeInsets.zero,
    );
  }
}
