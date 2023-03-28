// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/pages/sickness/behandling_page.dart';

class VitalPage extends StatefulWidget {
  const VitalPage({super.key});

  @override
  _VitalPageState createState() => _VitalPageState();
}

class CommaFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String _text = newValue.text;
    return newValue.copyWith(
      text: _text.replaceAll('.', ','),
    );
  }
}

class _VitalPageState extends State<VitalPage> {
  //droopdown buttion RLS
  // Initial Selected Value

  bool isO2mask = false; //patient["isO2mask"];
  //bool isNotO2mask = false; // patient["isNotO2mask"];

  //values checked'

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map activePatient = patientsModel.activePatient;

    TextEditingController tempController =
        TextEditingController(text: activePatient["temp"]);
    TextEditingController btController =
        TextEditingController(text: activePatient["blodtryck"]);

    final String datetime = activePatient.containsKey("startTime")
        ? activePatient["startTime"]
        : '${DateTime.now().hour} :${DateTime.now().minute}';

    final TextEditingController datetimeController =
        TextEditingController(text: datetime);

    return GestureDetector(
        child: Scaffold(
      //backgroundColor: // Color.fromARGB(255, 31, 74, 123),
      drawer: DrawerWidget(title: "RunProof"),
      appBar: AppBar(
        title: Image.asset('assets/images/runprooflogo.png',
            fit: BoxFit.contain, height: 60),
        backgroundColor: Color.fromARGB(255, 16, 47, 83),
      ),
      body: ListView(
        key: _formKey,
        children: [
          Container(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 187, 205, 231)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 1),
                          child: Text('VITALPARAMETRAR',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)))),
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8, width: 20),
          Center(
            child: TextFormField(
                textAlign: TextAlign.center,
                controller: datetimeController,
                //minLines: 1,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                      child: Text('TEMP:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ))),
                ),
                Expanded(
                    flex: 3,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                              onFieldSubmitted: (value) =>
                                  patientsModel.setAttribute("temp", value),
                              controller: tempController,
                              validator: (value1) {
                                if (value1 == null || value1.isEmpty) {
                                  return 'Vänligen fyll i temp';
                                }
                                return null;
                              },
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true, signed: true),
                              inputFormatters: <TextInputFormatter>[
                                CommaFormatter(),
                                FilteringTextInputFormatter.allow(RegExp(
                                  r'^[0-9]*[,]?[0-9]*',
                                )),
                              ],
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText:
                                      'Skriv in löparens temperatur här...',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Center(
              child: Text(
                'BLODTRYCK',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 187, 205, 231),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('PULS:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ))),
                          Expanded(
                              flex: 2,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                        onFieldSubmitted: (value) =>
                                            patientsModel.setAttribute(
                                                "puls", value),
                                        validator: (value1) {
                                          if (value1 == null ||
                                              value1.isEmpty) {
                                            return 'Vänligen fyll i puls';
                                          }
                                          return null;
                                        },
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true, signed: true),
                                        inputFormatters: <TextInputFormatter>[
                                          CommaFormatter(),
                                          FilteringTextInputFormatter.allow(
                                              RegExp(
                                            r'^[0-9]*',
                                          )),
                                        ],
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText:
                                                'Skriv in löparens puls här...',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))))),
                                  ])),
                        ],
                      ),
                    ),
                    IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              child: TextFormField(
                                minLines: 1,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Sysytole',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                              ),
                            ),
                            Spacer(flex: 1),
                            RotationTransition(
                              turns: AlwaysStoppedAnimation(35 / 360),
                              child: Container(
                                  width: 4, height: 60, color: Colors.black),
                            ),
                            Spacer(flex: 1),
                            Container(
                              width: 100,
                              child: TextFormField(
                                minLines: 1,
                                maxLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Diastole',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 60, right: 60, bottom: 15),
                        child: Row(
                          children: [
                            Spacer(flex: 2),
                            Container(
                              width: 150,
                              child: Text(
                                "% SATS:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            Spacer(flex: 2),
                            Container(
                                width: 100,
                                child: TextFormField(
                                    minLines: 1,
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: '%',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))))),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 60,
                          right: 60,
                        ),
                        child: Row(
                          children: [
                            Spacer(flex: 2),
                            Container(
                              width: 180,
                              child: Text(
                                "GLUKOS:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            Spacer(flex: 2),
                            Container(
                                width: 100,
                                child: TextFormField(
                                    minLines: 1,
                                    maxLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'mmol/l',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))))),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 15,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 1, left: 30),
                        child: Text('ÖVRIGT:',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18))),
                    Center(
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: 1, left: 15, right: 15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                      onFieldSubmitted: (value) => patientsModel
                                          .setAttribute("blodtryck", value),
                                      controller: btController,
                                      minLines: 4,
                                      maxLines: 6,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Skriv något här...',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))))),
                                ]))),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 150, right: 150),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VitalPage()));
                  },
                  child: const Text("+"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 61, 104, 129)))),
          Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 15, left: 40.0, right: 40),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: const Text("Back"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 163, 28, 71),
                    ),
                  ),
                ),
                Spacer(),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BehandlingPage()));
                    },
                    child: const Text("NÄSTA"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
