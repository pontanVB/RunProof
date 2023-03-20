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
                          "EAc Svim",
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

