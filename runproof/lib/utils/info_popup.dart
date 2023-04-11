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
  String? sex;
  int runningNumber;
  int age;

  showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      });

  getFromDatabase(searchNumber)
      .then((value) => {
            Navigator.pop(context),
            print(value),
            sex = value["sex"],
            age = value["age"],
            name = value["name"],
            runningNumber = value["runningNumber"],
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                contentPadding: const EdgeInsets.all(40),
                title: const Text(
                  'Löparinformation:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                backgroundColor: const Color(0xFF94B0DA),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Löparnummer:'),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child:
                              Icon(Icons.document_scanner_outlined, size: 40),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '$runningNumber',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(15.0)),
                    const Text('Kön:'),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.person_2_outlined, size: 40),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(5),
                            child: Text(
                              '$sex',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(15)),
                    const Text('Ålder:'),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.numbers, size: 40),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              '$age',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChoicePage()));

                            Provider.of<PatientsModel>(context, listen: false)
                                .addPatient(value);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: const Color(0xFF75C883),
                          ),
                          child: const Text(
                            "Lägg till",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.redAccent),
                            child: const Text(
                              'Avbryt',
                              style: TextStyle(fontSize: 18),
                            )),
                        const Spacer(),
                      ],
                    ),
                  )
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
