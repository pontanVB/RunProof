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
            value = renameAttributes(value, fromDatabase: true),
            sex = value["sex"],
            age = value["age"],
            name = value["name"],
            runningNumber = value["runningNumber"],
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                contentPadding: const EdgeInsets.all(30),
                title: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: const Text('LÖPARINFORMATION',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 23)),
                ),
                backgroundColor: Colors.white,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
                      child: Divider(
                        height: 10,
                        thickness: 2,
                        color: Colors.black,
                        indent: MediaQuery.of(context).size.width * 0.01,
                        endIndent: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            child:
                                Icon(Icons.document_scanner_outlined, size: 40),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01),
                                child: const Text(
                                  'Löparnummer:',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color.fromARGB(255, 16, 47, 83),
                                        width: 2)),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '$runningNumber',
                                  style: TextStyle(fontSize: 25),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(15.0)),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            child: Icon(Icons.person, size: 40),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01),
                                child: const Text('Kön:'),
                              ),
                              Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color.fromARGB(255, 16, 47, 83),
                                        width: 2)),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '$sex',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 25),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(15)),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.0),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            child: Icon(Icons.numbers, size: 40),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01),
                                child: const Text(
                                  'Ålder:',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Color.fromARGB(255, 16, 47, 83),
                                        width: 2)),
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  '$age',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ],
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

void CheckoutPopup(BuildContext context, int runningNumber) {
  showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          title: const Text("Utcheckning lyckades",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Patient med löparnummer ',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    children: <TextSpan>[
                      TextSpan(
                          text: '$runningNumber ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const TextSpan(text: 'har nu checkats ut'),
                    ],
                  ),
                ),
              ),
            ],
          ))));
}
