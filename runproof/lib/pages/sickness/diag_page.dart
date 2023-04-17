// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/pages/sickness/behandling_page.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import "package:provider/provider.dart";
import 'package:flutter/services.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/pages/utceck_page.dart';
import 'package:gbg_varvet/widgets/bottom_bar_widget.dart';

import '../../utils/info_popup.dart';

class DiagPage extends StatefulWidget {
  const DiagPage({super.key});

  @override
  _DiagPageState createState() => _DiagPageState();
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

class _DiagPageState extends State<DiagPage> {
  int radioValue = -1;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;
    bool breathingDifficulty =
        patient["sickness"]["breathingDifficulty"] ?? false;
    bool chestPain = patient["sickness"]["chestPain"] ?? false;
    bool stomachAche = patient["sickness"]["stomachAche"] ?? false;
    bool fainted = patient["sickness"]["fainted"] ?? false;
    TextEditingController diagKommentar =
        TextEditingController(text: patient["diagnos"]);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: DrawerWidget(title: "RunProof"),
          bottomNavigationBar: BottomBarWidget(
            forwardText: "NÄSTA",
            title: "R",
            nextPage: UtcheckPage(),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 16, 47, 83),
            title: Image.asset('assets/images/runprooflogo.png',
                fit: BoxFit.cover,
                height:60),
            centerTitle: true,
            actions: [
              Row(
                children: [
                  Center(
                      child: ElevatedButton(
                        onPressed: () => SavePopup(context),
                        style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.green,
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.2, 20)),
                          child: const Text("PAUSA"),
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  )
                ],
              ),
            ],
          ),
          body: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    color: Color.fromARGB(255, 187, 205, 231),
                    child: Padding(
                      padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.005),
                              child: Text('HUVUDDIAGNOS',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
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
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                breathingDifficulty = !breathingDifficulty;
                                patientsModel.setAttribute(
                                    "breathingDifficulty",
                                    breathingDifficulty,
                                    "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Andningssvårighet',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: breathingDifficulty
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                chestPain = !chestPain;
                                patientsModel.setAttribute(
                                    "chestPain", chestPain, "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Bröstsmärta',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: chestPain
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                stomachAche = !stomachAche;
                                patientsModel.setAttribute(
                                    "stomachAche", stomachAche, "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Buksmärta',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: stomachAche
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                fainted = !fainted;
                                patientsModel.setAttribute(
                                    "fainted", fainted, "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Svimning',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: fainted
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text('ÖVRIGT:',
                          style: TextStyle(color: Colors.black, fontSize: 18))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 1, left: 15, right: 15),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                        onFieldSubmitted: (value) =>
                                            patientsModel.setAttribute(
                                                "diagnos", value),
                                        controller: diagKommentar,
                                        minLines: 2,
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
                                  ])))),
                ],
              ))),
    );
  }
}
