// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/pages/sickness/behandling_page.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import "package:provider/provider.dart";
import 'package:flutter/services.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/utils/db_functions.dart';
import '../utils/info_popup.dart';

class UtcheckPage extends StatefulWidget {
  const UtcheckPage({super.key});

  @override
  _UtcheckPageState createState() => _UtcheckPageState();
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

class _UtcheckPageState extends State<UtcheckPage> {
  int radioValue = -1;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;

    print("$patient");
    TextEditingController checkComment =
        TextEditingController(text: patient["checkComment"]);

    bool goingHome = patient["goingHome"] ?? false;
    bool hospital = patient["hospital"] ?? false;
    bool continueing = patient["continueing"] ?? false;

    final String datetime = patient.containsKey("startTime")
        ? patient["startTime"]
        : '${DateTime.now().hour}:${DateTime.now().minute}';

    final TextEditingController datetimeController =
        TextEditingController(text: datetime);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: DrawerWidget(title: "RunProof"),
          appBar: AppBar(
            title: Image.asset('assets/images/runprooflogo.png',
                fit: BoxFit.contain, height: 60),
            backgroundColor: Color.fromARGB(255, 16, 47, 83),
            actions: [
              Row(
                children: [
                  Center(
                      child: ElevatedButton(
                    onPressed: () => SavePopup(context),
                    child: const Text("PAUSA"),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Color.fromARGB(255, 108, 211, 92),
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.2, 20)),
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
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 187, 205, 231)),
                    child: Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 1),
                                  child: Text('UTCHECKNING',
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
                    padding: const EdgeInsets.only(
                        bottom: 15.0, left: 15, right: 15, top: 30),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                goingHome = !goingHome;
                                patientsModel.setAttribute(
                                    "goingHome", goingHome);
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Hemgång',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: goingHome
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                hospital = !hospital;
                                patientsModel.setAttribute(
                                    "hospital", hospital);
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Sjukhus',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: hospital
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                continueing = !continueing;
                                patientsModel.setAttribute(
                                    "continueing", continueing);
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Fortsätter loppet',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: continueing
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 30),
                      child: Text('ÖVRIGT:',
                          style: TextStyle(color: Colors.black, fontSize: 18))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 1, left: 15, right: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                    onFieldSubmitted: (value) => patientsModel
                                        .setAttribute("checkComment", value),
                                    controller: checkComment,
                                    minLines: 4,
                                    maxLines: 6,
                                    textInputAction: TextInputAction.done,
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
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 80, top: 10),
                        child: SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 165, 39, 75),
                                  onPrimary: Colors.white),
                              child: const Text("TILLBAKA")),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 80, top: 10),
                          child: SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {
                                    patient = renameAttributes(patient,
                                        fromDatabase: false),
                                    _whatToSend(patient),
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst),
                                    patientsModel.removePatient(
                                        patientsModel.activeIndex),
                                  }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white),
                              child: const Text("CHECKA UT"),
                            ),
                          )),
                    ],
                  )
                ],
              ))),
    );
  }
}

void _whatToSend(Map patient) {
  // helper function for removing uncessesary information when sending to databse

  if (patient["type"] == "injury") {
    patient.remove("sjukdom");
  } else if (patient["type"] == "sickness") {
    patient.remove("skada");
  }

  sendToDatabase(patient, "6");
}
