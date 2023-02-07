// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}


class _FormPageState extends State<FormPage> {

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("form")),
      body: Column(
        children: [
          Center(
            child: TextField(
            decoration: InputDecoration(hintText: "Temp"),
            ),
          ),

          Center( //TEMP
            child: TextField(
              decoration: InputDecoration(hintText: "Vallad: Ja/Nej"),
            ),
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: CheckboxListTile(
                title: const Text("Test: "),
                autofocus: false,
                selected: _value,
                value: _value,
                onChanged: (bool? value){},
              ),
            ),
          ),

          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to first route when tapped.
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ),

        ],
      ),
    );
  }
}
