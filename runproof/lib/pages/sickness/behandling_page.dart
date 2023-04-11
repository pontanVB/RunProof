// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/utils/info_popup.dart';
import 'package:gbg_varvet/pages/sickness/diag_page.dart';

class BehandlingPage extends StatefulWidget {
  const BehandlingPage({super.key});

  @override
  _BehandlingPageState createState() => _BehandlingPageState();
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

class _BehandlingPageState extends State<BehandlingPage> {
  int radioValue = -1;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;
    bool intravenousFluid = patient["sickness"]["intravenousFluid"] ?? false;
    bool glucose = patient["sickness"]["givenGlucose"] ?? false;
    bool benso = patient["sickness"]["benso"] ?? false;
    bool inhalation = patient["sickness"]["inhalation"] ?? false;

    TextEditingController behandKommentar =
        TextEditingController(text: patient["behandling"]);

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
                          padding: EdgeInsets.only(top: 8.0, bottom: 10),
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 1),
                                  child: Text('BEHANDLING',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Divider(
                            height: 10,
                            thickness: 2,
                            color: Colors.black,
                            indent: 20,
                            endIndent: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                intravenousFluid = !intravenousFluid;
                                patientsModel.setAttribute("intravenousFluid",
                                    intravenousFluid, "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Intravenös vätska',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: intravenousFluid
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                glucose = !glucose;
                                patientsModel.setAttribute(
                                    "givenGlucose", glucose, "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Glukos',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: glucose
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                benso = !benso;
                                patientsModel.setAttribute(
                                    "benso", benso, "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Benso diasepiner',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: benso
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8.0, right: 8.0, bottom: 15),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.14,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                inhalation = !inhalation;
                                patientsModel.setAttribute(
                                    "inhalation", inhalation, "sickness");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Inhalation',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: inhalation
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: Text('ÖVRIGT:',
                          style: TextStyle(color: Colors.black, fontSize: 18))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 1, left: 15, right: 15),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                        onFieldSubmitted: (value) =>
                                            patientsModel.setAttribute(
                                                "bahandling",
                                                value,
                                                "sickness"),
                                        controller: behandKommentar,
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
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 0,
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("TILLBAKA"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 163, 28, 71),
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                          ),
                        ),
                        Spacer(flex: 1),
                        Expanded(
                          flex: 7,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DiagPage()));
                            },
                            child: const Text("NÄSTA"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
