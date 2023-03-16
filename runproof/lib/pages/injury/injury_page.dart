// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/pages/form_page_2.dart';
import 'package:provider/provider.dart';
import "package:gbg_varvet/utils/info_popup.dart";

// TODO: kolla om detta sättet med state är ok, typ performance eller alternativa lösningar

class InjuryPage extends StatefulWidget {
  const InjuryPage({super.key});

  @override
  _InjuryPageState createState() => _InjuryPageState();
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

class _InjuryPageState extends State<InjuryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;
    print("$patient");
    bool chafe = patient["injury"]["chafe"] ?? false; // skavsår
    bool sprain = patient["injury"]["sprain"] ?? false;
    bool pain = patient["injury"]["pain"] ?? false;
    bool cramp = patient["injury"]["cramp"] ?? false;
    bool home = patient["injury"]["home"] ?? false;
    bool hospital = patient["injury"]["hospital"] ?? false;

    TextEditingController tempController =
        TextEditingController(text: patient["temp"]);

    return Scaffold(
        backgroundColor: const Color(0xFF1F4A7B),
        drawer: DrawerWidget(title: "RunProof"),
        appBar: AppBar(
          title: Image.asset('assets/images/runprooflogo.png',
              fit: BoxFit.contain, height: 60),
          backgroundColor: Color.fromARGB(255, 142, 184, 223),
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
                Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: const [
                        Expanded(
                            child: Text('REGISTRERING AV SKADA',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ],
                    )),
                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                ),
                Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('TYP AV SKADA:',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)))),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, bottom: 8, left: 50, right: 60),
                  child: Column(
                    children: [
                      CheckboxListTile(
                        title: const Text(
                          "SKAVSÅR",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: chafe,
                        onChanged: (bool? value) {
                          setState(() {
                            chafe = value!;
                            patientsModel.setAttribute(
                                "chafe", chafe, "injury");
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      CheckboxListTile(
                        title: const Text(
                          "STUKAD FOTLED",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: sprain,
                        onChanged: (bool? value) {
                          setState(() {
                            sprain = value!;
                            patientsModel.setAttribute(
                                "sprain", sprain, "injury");
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      CheckboxListTile(
                        title: const Text(
                          "MUSKELVÄRK",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: pain,
                        onChanged: (bool? value) {
                          setState(() {
                            pain = value!;
                            patientsModel.setAttribute("pain", pain, "injury");
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      CheckboxListTile(
                        title: const Text(
                          "KRAMP",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: cramp,
                        onChanged: (bool? value) {
                          setState(() {
                            cramp = value!;
                            patientsModel.setAttribute(
                                "cramp", cramp, "injury");
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
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
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Text('FORTSÄTTER HEM',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)))),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 45, left: 45),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: CheckboxListTile(
                              title: const Text(
                                "JA",
                                style: TextStyle(color: Colors.white),
                              ),
                              autofocus: false,
                              selected: false,
                              value: home,
                              onChanged: (bool? value) {
                                setState(() {
                                  hospital = value! ? false : true;
                                  home = value;
                                  patientsModel.setAttribute(
                                      "home", home, "injury");
                                  patientsModel.setAttribute(
                                      "hospital", hospital, "injury");
                                });
                              },
                              activeColor: Colors.green,
                              checkColor: Colors.white,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              title: const Text(
                                "NEJ",
                                style: TextStyle(color: Colors.white),
                              ),
                              autofocus: false,
                              selected: false,
                              value: hospital, //isNotOver,
                              onChanged: (bool? value) {
                                setState(() {
                                  home = value! ? false : true;
                                  hospital = value;
                                  patientsModel.setAttribute(
                                      "home", home, "injury");
                                  patientsModel.setAttribute(
                                      "hospital", hospital, "injury");
                                });
                              },
                              activeColor: Colors.red,
                              checkColor: Colors.white,
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ], //Column children
                ),
                Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 1),
                        child: Text('KOMMENTAR:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)))),
                Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 19.0, bottom: 1, left: 15, right: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                  minLines: 4,
                                  maxLines: 6,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Skriv något här...',
                                      hintStyle: TextStyle(color: Colors.grey),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const InjuryPage()))
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 108, 211, 92),
                                onPrimary: Colors.white),
                            child: const Text("NÄSTA"),
                          ),
                        )),
                  ],
                )
              ],
            )));
  }
}
