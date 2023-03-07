// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import "package:provider/provider.dart";
import 'package:flutter/services.dart';
import 'package:gbg_varvet/pages/form_page_2.dart';
import "package:gbg_varvet/utils/utils.dart";

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
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

class _FormPageState extends State<FormPage> {
  bool isVal = false;
  bool isNotVal = false;
  bool isKon = false;
  bool isOko = false;
  bool isKra = false;
  bool isSal = false;
  bool isOver = false;
  bool isNotOver = false;

  int radioValue = -1;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;
    print("$patient");
    bool isVal = patient["isVal"];
    bool isNotVal = patient["isNotVal"];
    bool isKon = patient["isKon"];
    bool isOko = patient["isOko"];
    bool isKra = patient["isKra"];
    bool isSal = patient["isSal"];
    bool isOver = patient["isOver"];
    bool isNotOver = patient["isNotOver"];
    TextEditingController tempController =
        TextEditingController(text: patient["temp"]);
    TextEditingController overKommentar =
        TextEditingController(text: patient["overkanslighet"]);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: const Color(0xFF1F4A7B),
          drawer: DrawerWidget(title: "RunProof"),
          appBar: AppBar(
            title: Image.asset('assets/images/runprooflogo.png',
                fit: BoxFit.cover, height: 60.0, width: 60.0),
            centerTitle: true,
            backgroundColor: Color(0xFF94B0DA),
          ),
          body: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/form_page_pluppar.png',
                          width: 200,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text('TEMP:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Expanded(
                            flex: 3,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                      onFieldSubmitted: (value) => patientsModel
                                          .setAttribute("temp", value),
                                      controller: tempController,
                                      validator: (value1) {
                                        if (value1 == null || value1.isEmpty) {
                                          return 'Vänligen fyll i temp';
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
                                          r'^[0-9]*[,]?[0-9]*',
                                        )),
                                      ],
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText:
                                              'Skriv in löparens temperatur här...',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))))),
                                ])),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("VALLAD:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20)),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: const Text(
                              "JA",
                              style: TextStyle(color: Colors.white),
                            ),
                            autofocus: false,
                            selected: false,
                            value: isVal,
                            onChanged: (bool? value) {
                              setState(() {
                                isNotVal = value! ? false : true;
                                isVal = value;
                                patientsModel.setAttribute(
                                    "isNotVal", isNotVal);
                                patientsModel.setAttribute("isVal", isVal);
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
                            value: isNotVal,
                            onChanged: (bool? value) {
                              setState(() {
                                isVal = value! ? false : true;
                                isNotVal = value;
                                patientsModel.setAttribute(
                                    "isNotVal", isNotVal);
                                patientsModel.setAttribute("isVal", isVal);
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
                          child: Text('STATUS:',
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
                            "KONFUSION ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          autofocus: false,
                          selected: false,
                          value: isKon,
                          onChanged: (bool? value) {
                            setState(() {
                              isKon = value!;
                              patientsModel.setAttribute("isKon", isKon);
                            });
                          },
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                        ),
                        CheckboxListTile(
                          title: const Text(
                            "OKONTAKTBAR ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          autofocus: false,
                          selected: false,
                          value: isOko,
                          onChanged: (bool? value) {
                            setState(() {
                              isOko = value!;
                              patientsModel.setAttribute("isOko", isOko);
                            });
                          },
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                        ),
                        CheckboxListTile(
                          title: const Text(
                            "KRÄKNING ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          autofocus: false,
                          selected: false,
                          value: isKra,
                          onChanged: (bool? value) {
                            setState(() {
                              isKra = value!;
                              patientsModel.setAttribute("isKra", isKra);
                            });
                          },
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                        ),
                        CheckboxListTile(
                          title: const Text(
                            "SALTPAKET ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          autofocus: false,
                          selected: false,
                          value: isSal,
                          onChanged: (bool? value) {
                            setState(() {
                              isSal = value!;
                              patientsModel.setAttribute("isSal", isSal);
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
                          child: Text('ÖVERKÄNSLIGHET:',
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
                                value: isOver,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isNotOver = value! ? false : true;
                                    isOver = value;
                                    patientsModel.setAttribute(
                                        "isOver", isOver);

                                    patientsModel.setAttribute(
                                        "isNotOver", isNotOver);
                                  });
                                },
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                title: const Text(
                                  "INGEN KÄND",
                                  style: TextStyle(color: Colors.white),
                                ),
                                autofocus: false,
                                selected: false,
                                value: isNotOver,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isOver = value! ? false : true;
                                    isNotOver = value;
                                    patientsModel.setAttribute(
                                        "isNotOver", isNotOver);
                                    patientsModel.setAttribute(
                                        "isOver", isOver);
                                  });
                                },
                                activeColor: Colors.red,
                                checkColor: Colors.white,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18)))),
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 19.0, bottom: 1, left: 15, right: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                    onFieldSubmitted: (value) => patientsModel
                                        .setAttribute("overkanslighet", value),
                                    controller: overKommentar,
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
                                              const FormPage2()))
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
              ))),
    );
  }
}
