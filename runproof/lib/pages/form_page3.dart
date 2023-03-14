// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:gbg_varvet/pages/form_page_2.dart';
import 'package:gbg_varvet/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:gbg_varvet/utils/utils.dart';

class FormPage3 extends StatefulWidget {
  const FormPage3({super.key});

  @override
  _FormPage3State createState() => _FormPage3State();
}

class _FormPage3State extends State<FormPage3> {
  //droopdown buttion RLS
// Initial Selected Value

  bool isO2mask = false; //patient["isO2mask"];
  //bool isNotO2mask = false; // patient["isNotO2mask"];

  String dropdownvalue = '1';

  // List of items in our dropdown menu
  var items = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];

  //values checked

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map activePatient = patientsModel.activePatient;

    final String datetime = activePatient.containsKey("startTime")
        ? activePatient["startTime"]
        : '${DateTime.now().hour} :${DateTime.now().minute}';

    final TextEditingController datetimeController =
        TextEditingController(text: datetime);

    return Scaffold(
      //backgroundColor: // Color.fromARGB(255, 31, 74, 123),
      drawer: DrawerWidget(title: "RunProof"),
      appBar: AppBar(
        title: Image.asset('assets/images/runprooflogo.png',
            fit: BoxFit.contain, height: 60),
        backgroundColor: Color.fromARGB(255, 142, 184, 223),
      ),
      body: ListView(
        children: [
          Center(
            child: TextFormField(
                textAlign: TextAlign.center,
                controller: datetimeController,
                //minLines: 1,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Puls',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Puls',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 10,
            thickness: 2,
            color: Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          Center(
            child: Text(
              'Blodtryck',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
          IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    width: 150,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                  Spacer(flex: 1),
                  RotationTransition(
                    turns: AlwaysStoppedAnimation(35 / 360),
                    child: Container(width: 4, height: 60, color: Colors.white),
                  ),
                  Spacer(flex: 1),
                  Container(
                    width: 150,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              'Kommentar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 15, left: 15, right: 15),
            child: TextFormField(
                minLines: 4,
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Skriv något här...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))))),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Row(
                children: [
                  Spacer(flex: 1),
                  Container(
                    width: 150,
                    child: Text(
                      "Saturation:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                  Spacer(flex: 2),
                  Container(
                      width: 60,
                      child: TextFormField(
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '95',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))))),
                  Container(
                    width: 60,
                    child: Text(
                      '%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
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
              child: Row(
                children: [
                  Spacer(flex: 1),
                  Container(
                    width: 150,
                    child: Text(
                      "Andingsfrekvens:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                  Spacer(flex: 2),
                  Container(
                      width: 60,
                      child: TextFormField(
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: '20',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))))),
                  Container(
                    width: 60,
                    child: Text(
                      '/min',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
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
              child: Row(
                children: [
                  Text('RLS:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                  Spacer(flex: 1),
                  Container(
                    padding:
                        EdgeInsets.only(top: 1, bottom: 1, left: 5, right: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),

                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      //underline: Container(
                      //  height: 2,
                      //  color: Colors.black,
                      //),
                    ),
                  ),
                  Spacer(flex: 2),
                  Text(
                    "O2:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                  Spacer(flex: 1),
                  Transform.scale(
                    scale: 1.7,
                    child: Checkbox(
                      autofocus: false,
                      //selected: false,
                      value: isO2mask,
                      onChanged: (bool? value) {
                        setState(
                          () {
                            isO2mask = value!; // ? false : true;

                            //patientsModel.setAttribute(
                            //    "isNotO2mask", isO2mask);
                          },
                        );
                      },

                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      //controlAffinity: ListTileControlAffinity
                      //   .trailing, //  <-- leading Checkbox
                    ),
                  ),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 30, bottom: 15, left: 20.0, right: 20),
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
                              builder: (context) => const HomePage()));
                    },
                    child: const Text("Home"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FormPage3()));
                    },
                    child: const Text("+"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
