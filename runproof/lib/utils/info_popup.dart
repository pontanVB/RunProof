import 'package:flutter/material.dart';
import "package:gbg_varvet/utils/db_functions.dart";

void infoPopupEmpty(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Löparinformation:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.content_copy),
                  hintText: 'Löparnummer',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey,
                      )))),
          Padding(padding: EdgeInsets.all(7.0)),
          TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Namn',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey,
                      )))),
          Padding(padding: EdgeInsets.all(7.0)),
          TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.numbers),
                  hintText: 'Personnummer',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey,
                      )))),
          Padding(padding: EdgeInsets.all(7.0)),
          TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  labelText: 'Ankomsttid...',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        width: 2.0,
                        color: Colors.grey,
                      )))),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

void infoPopupFull(BuildContext context, String searchNumber) {
  String name;
  int runningNumber;
  int idNumber;

  getFromDatabase(searchNumber)
      .then((value) => {
            print(value),
            runningNumber = value["runningNumber"],
            name = value["name"],
            idNumber = value["idNumber"],
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Löparinformation:'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(padding: EdgeInsets.all(7.0)),
                    Row(
                      children: [
                        Icon(Icons.content_copy),
                        Expanded(
                          child: Text(
                            'Löparnummer: $runningNumber',
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(7.0)),
                    Row(
                      children: [
                        Icon(Icons.numbers),
                        Expanded(
                          child: Text(
                            'Name: $name',
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(7.0)),
                    Row(
                      children: [
                        Icon(Icons.timer),
                        Expanded(
                          child: Text(
                            'Personnummer: $idNumber',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            )
          })
      .catchError((error) => {print("Error $error")});
}
