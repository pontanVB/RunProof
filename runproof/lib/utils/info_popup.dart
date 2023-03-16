import 'package:flutter/material.dart';
import "package:gbg_varvet/utils/db_functions.dart";
import "package:gbg_varvet/utils/utils.dart";
import 'package:provider/provider.dart';
import "package:gbg_varvet/pages/choice_page.dart";

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
                        Icon(Icons.numbers),
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
                        Icon(Icons.person_outline),
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
                        Icon(Icons.schedule),
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
                        Icon(Icons.description),
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
                              builder: (context) => const ChoicePage()));

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

void SavePopup(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Color.fromARGB(255, 220, 237, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 31, 74, 123),
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
                child: Text(
              "ÄR DU SÄKER PÅ ATT DU VILL SPARA & PAUSA?",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: const Center(
                child: Text(
              "DU KAN ALLTID VÄLJA ATT SKANNA NUMMERLAPPEN IGEN OCH FORTSÄTTA VID SENARE TILLFÄLLE\n\nOBS!\n\nKOM IHÅG ATT AVSLUTA ÄRENDET OM PATIENTEN ÄR HELT KLAR",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            )),
          )
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('NEJ'),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 20),
                  backgroundColor: Color.fromARGB(255, 87, 95, 110),
                  shape: const StadiumBorder()),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text('SPARA'),
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.3, 20),
                  backgroundColor: Color.fromARGB(255, 108, 211, 92),
                  shape: const StadiumBorder()),
            ),
          ],
        ),
      ],
    ),
  );
}
