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
          bottomNavigationBar: BottomAppBar(
            color: const Color.fromARGB(255, 16, 47, 83),
            child: Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 0,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color.fromARGB(255, 165, 39, 75),
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.02)),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('TILLBAKA')),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 7,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height * 0.02)),
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {
                              _whatToSend(patient),
                              Navigator.of(context).popUntil((route) => route.isFirst),
                              print(patientsModel.activeIndex),
                              patientsModel.removePatient(patientsModel.activeIndex),
                            }
                        },
                        child: Text('CHECKA UT')),
                  ),
                ],
              ),
            ),
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
                            child: Text('UTCHECKNING',
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.12,
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
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(
                            () {
                              hospital = !hospital;
                              patientsModel.setAttribute("hospital", hospital);
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
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.12,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: 20,
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
                                      onFieldSubmitted: (value) => patientsModel
                                          .setAttribute("checkComment", value),
                                      controller: checkComment,
                                      minLines: 2,
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
                                ]
                            )
                        )
                    )
                ),
              ],
            ),
          )),
    );
  }
}

void _whatToSend(Map patient) {
  // helper function for removing uncessesary information when sending to databse
  if (patient["type"] == "injury") {
    patient.remove("sickness");
  } else if (patient["type"] == "sickness") {
    patient.remove("injury");
  }
  sendToDatabase(patient, "4");
}
