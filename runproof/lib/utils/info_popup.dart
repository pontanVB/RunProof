import 'package:flutter/material.dart';
import "package:gbg_varvet/utils/db_functions.dart";
import "package:gbg_varvet/utils/utils.dart";
import "package:gbg_varvet/pages/form_page.dart";
import 'package:provider/provider.dart';

void errorPopup(BuildContext context, error) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Försök igen!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text("$error")],
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

void runnerInfoPopup(BuildContext context, String searchNumber) {
  String? name;
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
                  ElevatedButton(
                    child: Text("Lägg till"),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormPage()));

                      Provider.of<PatientsModel>(context, listen: false)
                          .addPatient(
                              {"name": name, "runningNumber": runningNumber});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF75C883),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Avbryt'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent))
                ],
              ),
            )
          })
      .catchError((error) => {print("$error"), errorPopup(context, error)});
}
