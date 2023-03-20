// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/pages/form_page_2.dart';
import 'package:provider/provider.dart';
import "package:gbg_varvet/utils/info_popup.dart";
import 'package:gbg_varvet/widgets/design_widget.dart';

// TODO: kolla om detta sättet med state är ok, typ performance eller alternativa lösningar

class DiagnosisPage extends StatefulWidget {
  const DiagnosisPage({super.key});

  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
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

class _DiagnosisPageState extends State<DiagnosisPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;
    print("$patient");
    bool eac = patient["eac"] ?? false; // svimnning eller kollaps
    bool abdominalPain = patient["abdominalPain"] ?? false;
    bool breathingProblems = patient["breathingProblems"] ?? false;
    bool chestPain = patient["chestPain"] ?? false;


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
                Padding(            padding: const EdgeInsets.all(20),

                child: Center(

                          child: TextTitle(text: "Diagnos",),
                    ),),

                Divider(
                  height: 10,
                  thickness: 2,
                  color: Colors.black,
                  indent: 20,
                  endIndent: 20,
                ),
                 Center(
                  child: Column(
                    children: [


                      CheckboxListTile(
                        title: const Text(
                          "Svimning",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: eac,
                        onChanged: (bool? value) {
                          setState(() {
                            eac = value!;
                            patientsModel.setAttribute(
                                "eac", eac);
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      CheckboxListTile(
                        title: const Text(
                          "Buksmärtor",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: abdominalPain,
                        onChanged: (bool? value) {
                          setState(() {
                            abdominalPain = value!;
                            patientsModel.setAttribute(
                                "abdominalPain", abdominalPain);
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      CheckboxListTile(
                        title: const Text(
                          "Andningssvår",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: breathingProblems,
                        onChanged: (bool? value) {
                          setState(() {
                            breathingProblems = value!;
                            patientsModel.setAttribute(
                                "breathingProblems", breathingProblems);
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      CheckboxListTile(
                        title: const Text(
                          "Bröstsmärtor",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        autofocus: false,
                        selected: false,
                        value: chestPain,
                        onChanged: (bool? value) {
                          setState(() {
                            chestPain = value!;
                            patientsModel.setAttribute(
                                "chestPain", chestPain);
                          });
                        },
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),

                    ],
                  ),
                ),


             Padding(
                        padding: EdgeInsets.only(left:20, top: 10, bottom: 1),
                        child: Text('Övrigt:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18))),
                Center(
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 19.0, bottom: 1, left: 20, right: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                  minLines: 1,
                                  maxLines: 6,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Förklaring ICD.',
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
                                            const DiagnosisPage()))
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

