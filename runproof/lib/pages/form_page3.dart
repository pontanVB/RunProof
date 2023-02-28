// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:gbg_varvet/pages/form_page.dart';

import 'package:gbg_varvet/pages/home_page.dart';

class FormPage3 extends StatefulWidget {
  const FormPage3({super.key});

  @override
  _FormPage3State createState() => _FormPage3State();
}

class _FormPage3State extends State<FormPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 74, 123),
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
                //minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  //fillColor: Colors.white,
                  hintText: '${DateTime.now().hour} :${DateTime.now().minute}',
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text('Puls'),
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
            child: Row(
              children: [
                Expanded(
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
                VerticalDivider(
                  //TODO vrid 45 grader och gör så att den syns
                  color: Colors.white,
                  thickness: 5,
                ),
                Expanded(
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
          Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              'Kommentar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, bottom: 1, left: 15, right: 15),
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
            child: Row(
              children: [
                Text(
                  "Saturation",
                ),
                Spacer(),
                Container(
                    width: 100,
                    child: TextFormField(
                        minLines: 1,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Skriv något här...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))))))
              ],
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FormPage()));
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
