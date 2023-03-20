import 'package:flutter/material.dart';


class TextTitle extends StatelessWidget {
  String text="";
  TextTitle({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ));
  }
}

