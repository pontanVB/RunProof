// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/utils/info_popup.dart';
import 'package:gbg_varvet/pages/sickness/behandling_page.dart';
import 'package:gbg_varvet/widgets/bottom_bar_widget.dart';
import 'dart:io' show Platform;

class VitalPage extends StatefulWidget {
  const VitalPage({super.key});

  @override
  _VitalPageState createState() => _VitalPageState();
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

void _updateAttributes(
    Map<String, TextEditingController> controllers, PatientsModel model) {
  controllers.forEach((key, value) {
    model.setAttribute(key, value.text, "sickness");
  });
}

class _VitalPageState extends State<VitalPage> {
  //droopdown buttion RLS
  // Initial Selected Value

  bool isO2mask = false; //patient["isO2mask"];
  //bool isNotO2mask = false; // patient["isNotO2mask"];

  //values checked'

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map activePatient = patientsModel.activePatient;

    TextEditingController tempController =
        TextEditingController(text: activePatient["sickness"]["temp"] ?? "");
    TextEditingController btController = TextEditingController(
        text: activePatient["sickness"]["bloodPressure"] ?? "");
    TextEditingController sysytoleController = TextEditingController(
        text: activePatient["sickness"]["sysytole"] ?? "");
    TextEditingController diastoleController = TextEditingController(
        text: activePatient["sickness"]["diastole"] ?? "");
    TextEditingController satsController =
        TextEditingController(text: activePatient["sickness"]["sats"] ?? "");
    TextEditingController glucoseController =
        TextEditingController(text: activePatient["sickness"]["glucose"] ?? "");
    TextEditingController commentController = TextEditingController(
        text: activePatient["sickness"]["bloodPressureComment"] ?? "");
    TextEditingController pulseController =
        TextEditingController(text: activePatient["sickness"]["pulse"] ?? "");
    print(activePatient);
    // map for all controllers so we update all at the same time
    Map<String, TextEditingController> controllersMap = {
      "temp": tempController,
      "bloodPressure": btController,
      "sysytole": sysytoleController,
      "diastole": diastoleController,
      "sats": satsController,
      "glucose": glucoseController,
      "bloodPressureComment": commentController,
      "pulse": pulseController
    };

    final String datetime = activePatient.containsKey("startTime")
        ? activePatient["startTime"]
        : '${DateTime.now().hour}:${DateTime.now().minute}';

    final TextEditingController datetimeController =
        TextEditingController(text: datetime);

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        onVerticalDragEnd: (DragEndDetails details) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          //backgroundColor: // Color.fromARGB(255, 31, 74, 123),
          drawer: DrawerWidget(title: "RunProof"),
          bottomNavigationBar: BottomBarWidget(
            forwardText: "NÄSTA",
            title: "R",
            nextPage:
                MaterialPageRoute(builder: (context) => const BehandlingPage()),
          ),
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
          body: ListView(
            key: _formKey,
            children: [
              Container(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 187, 205, 231)),
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 1),
                              child: Text('VITALPARAMETRAR',
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
              const SizedBox(height: 8, width: 20),
              Center(
                child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: datetimeController,
                    onFieldSubmitted: (String value) {
                      String hour = value.substring(0, 2);
                      String minutes = value.substring(2, 4);
                      String newTime = "$hour:$minutes";
                      patientsModel.setAttribute("startTime", newTime);
                    },
                    //minLines: 1,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                    keyboardType: Platform.isIOS
                        ? TextInputType.numberWithOptions(
                            signed: true, decimal: true)
                        : TextInputType.number,
// This regex for only amount (price). you can create your own regex based on your requirement
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,4}'))
                    ],
                    decoration: InputDecoration(
                      filled: true,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                          child: Text('TEMP:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ))),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                  onFieldSubmitted: (value) =>
                                      _updateAttributes(
                                          controllersMap, patientsModel),
                                  controller: tempController,
                                  validator: (value1) {
                                    if (value1 == null || value1.isEmpty) {
                                      return 'Vänligen fyll i temp';
                                    }
                                    return null;
                                  },
                                  minLines: 1,
                                  maxLines: 1,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true, signed: true),
                                  inputFormatters: <TextInputFormatter>[
                                    CommaFormatter(),
                                    FilteringTextInputFormatter.allow(RegExp(
                                      r'^[0-9]*[,]?[0-9]*',
                                    )),
                                  ],
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText:
                                          'Skriv in löparens temperatur här...',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))))),
                            ])),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Center(
                  child: Text(
                    'BLODTRYCK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 187, 205, 231),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text('PULS:',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ))),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                            onFieldSubmitted: (value) =>
                                                _updateAttributes(
                                                    controllersMap,
                                                    patientsModel),
                                            validator: (value1) {
                                              if (value1 == null ||
                                                  value1.isEmpty) {
                                                return 'Vänligen fyll i puls';
                                              }
                                              return null;
                                            },
                                            controller: pulseController,
                                            minLines: 1,
                                            maxLines: 1,
                                            keyboardType: Platform.isIOS
                                                ? TextInputType
                                                    .numberWithOptions(
                                                        signed: true,
                                                        decimal: true)
                                                : TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              CommaFormatter(),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(
                                                r'^[0-9]*',
                                              )),
                                            ],
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                hintText:
                                                    'Skriv in löparens puls här...',
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(Radius
                                                            .circular(20))))),
                                      ])),
                            ],
                          ),
                        ),
                        IntrinsicHeight(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, bottom: 20),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    onFieldSubmitted: (value) =>
                                        _updateAttributes(
                                            controllersMap, patientsModel),
                                    controller: sysytoleController,
                                    minLines: 1,
                                    maxLines: 1,
                                    keyboardType: Platform.isIOS
                                        ? TextInputType.numberWithOptions(
                                            signed: true, decimal: true)
                                        : TextInputType.number,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Sysytole',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                ),
                                Spacer(flex: 1),
                                RotationTransition(
                                  turns: AlwaysStoppedAnimation(35 / 360),
                                  child: Container(
                                      width: 4,
                                      height: 60,
                                      color: Colors.black),
                                ),
                                Spacer(flex: 1),
                                Container(
                                  width: 100,
                                  child: TextFormField(
                                    onFieldSubmitted: (value) =>
                                        _updateAttributes(
                                            controllersMap, patientsModel),
                                    controller: diastoleController,
                                    minLines: 1,
                                    maxLines: 1,
                                    keyboardType: Platform.isIOS
                                        ? TextInputType.numberWithOptions(
                                            signed: true, decimal: true)
                                        : TextInputType.number,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Diastole',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 60, right: 60, bottom: 15),
                            child: Row(
                              children: [
                                Spacer(flex: 2),
                                Container(
                                  width: 150,
                                  child: Text(
                                    "% SATS:",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Spacer(flex: 2),
                                Container(
                                    width: 100,
                                    child: TextFormField(
                                        onFieldSubmitted: (value) =>
                                            _updateAttributes(
                                                controllersMap, patientsModel),
                                        controller: satsController,
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType: Platform.isIOS
                                            ? TextInputType.numberWithOptions(
                                                signed: true, decimal: true)
                                            : TextInputType.number,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: '%',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))))),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 60,
                              right: 60,
                            ),
                            child: Row(
                              children: [
                                Spacer(flex: 2),
                                Container(
                                  width: 180,
                                  child: Text(
                                    "GLUKOS:",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                                Spacer(flex: 2),
                                Container(
                                    width: 100,
                                    child: TextFormField(
                                        onFieldSubmitted: (value) =>
                                            _updateAttributes(
                                                controllersMap, patientsModel),
                                        controller: glucoseController,
                                        minLines: 1,
                                        maxLines: 1,
                                        keyboardType: Platform.isIOS
                                            ? TextInputType.numberWithOptions(
                                                signed: true, decimal: true)
                                            : TextInputType.number,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: 'mmol/l',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))))),
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
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 1, left: 30),
                            child: Text('ÖVRIGT:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18))),
                        Center(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 1, left: 15, right: 15),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextFormField(
                                          onFieldSubmitted: (value) =>
                                              _updateAttributes(controllersMap,
                                                  patientsModel),
                                          controller: commentController,
                                          minLines: 4,
                                          maxLines: 6,
                                          textInputAction: TextInputAction.go,
                                          keyboardType: TextInputType.multiline,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'Skriv något här...',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20))))),
                                    ]))),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 150, right: 150),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VitalPage()));
                      },
                      child: const Text("+"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 61, 104, 129)))),
            ],
          ),
        ));
  }
}
