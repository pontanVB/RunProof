import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddNewPatient extends StatelessWidget {
  const AddNewPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.all(7.0)),
          Row(
            children: [
              Icon(Icons.numbers),
              Expanded(
                child: Text(
                  'Löparnummer: ',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          Row(
            children: [
              Icon(Icons.person_outline),
              Expanded(
                child: Text(
                  'Löparnummer: ',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          Row(
            children: [
              Icon(Icons.schedule),
              Expanded(
                child: Text(
                  'Name: ',
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(7.0)),
          Row(
            children: [
              Icon(Icons.description),
              Expanded(
                child: Text(
                  'Personnummer: ',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
