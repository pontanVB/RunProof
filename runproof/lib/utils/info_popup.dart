import "dart:io";

import 'package:flutter/material.dart';
import "package:flutter/services.dart";
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
        children: [Text("${error.message}")],
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

void errorPopupWithOption(BuildContext context, error) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      scrollable: true,
      title: Text("Patient ${error.message}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [Text("Vill du lägga till som ny patient?")],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: const Color(0xFF75C883),
            ),
            onPressed: () => showEditableInfo(context),
            child: const Text("JA")),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.redAccent),
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('NEJ'),
        ),
      ],
    ),
  );
}

void showEditableInfo(BuildContext context, {Map? patient}) {
  final TextEditingController ageController = patient != null
      ? TextEditingController(text: patient["age"].toString())
      : TextEditingController();
  final TextEditingController runningNumberController = patient != null
      ? TextEditingController(text: patient["runningNumber"].toString())
      : TextEditingController();
  final TextEditingController sexController = patient != null
      ? TextEditingController(text: patient["sex"].toString())
      : TextEditingController();
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.all(20),
      title: Padding(
        padding:
            EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.001),
        child: const Text('LÖPARINFORMATION',
            textAlign: TextAlign.center, style: TextStyle(fontSize: 23)),
      ),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.01),
            child: Divider(
              height: 0,
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
                      top: MediaQuery.of(context).size.height * 0.0),
                  child: Icon(Icons.document_scanner_outlined, size: 40),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.01),
                      child: const Text(
                        'Löparnummer:',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 16, 47, 83),
                              width: 2)),
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: Platform.isIOS
                            ? TextInputType.numberWithOptions(
                                signed: true, decimal: true)
                            : TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        controller: runningNumberController,
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(5.0)),
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
                          bottom: MediaQuery.of(context).size.height * 0.01),
                      child: const Text('Kön:'),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 16, 47, 83),
                              width: 2)),
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: sexController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(5)),
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
                          bottom: MediaQuery.of(context).size.height * 0.01),
                      child: const Text(
                        'Ålder:',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 16, 47, 83),
                              width: 2)),
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: Platform.isIOS
                            ? TextInputType.numberWithOptions(
                                signed: true, decimal: true)
                            : TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        controller: ageController,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    closeKeyboard(context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChoicePage()));

                    if (patient == null) {
                      Provider.of<PatientsModel>(context, listen: false)
                          .addPatient({
                        "sex": sexController.text,
                        "runningNumber":
                            int.parse(runningNumberController.text),
                        "age": int.parse(ageController.text),
                      });
                    } else {
                      patient["sex"] = sexController.text;
                      patient["runningNumber"] =
                          int.parse(runningNumberController.text);
                      patient["age"] = int.parse(ageController.text);
                      Provider.of<PatientsModel>(context, listen: false)
                          .addPatient(patient);
                    }
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
                      Provider.of<PatientsModel>(context, listen: false)
                          .removePatient(0);
                      // Navigator.of(context).pop();
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
            showEditableInfo(context, patient: value)
          })
      .catchError((error) => {
            Navigator.pop(context),
            if (error is TypeError)
              {errorPopup(context, error)}
            else
              {print("$error"), errorPopupWithOption(context, error)}
          });
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

void closeKeyboard(BuildContext context) {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}
