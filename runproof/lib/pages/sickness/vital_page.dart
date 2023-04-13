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
          drawer: DrawerWidget(title: "RunProof"),
          bottomNavigationBar: BottomBarWidget(
            forwardText: "NÄSTA",
            title: "R",
            nextPage:
                MaterialPageRoute(builder: (context) => const BehandlingPage()),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 16, 47, 83),
            title: Image.asset('assets/images/runprooflogo.png',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.15),
            centerTitle: true,
            actions: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => SavePopup(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Color.fromARGB(255, 108, 211, 92),
                    ),
                    child: const Text("PAUSA"),
                  ),
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
                color: Color.fromARGB(255, 187, 205, 231),
                child: Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.005),
                          child: Text('VITALPARAMETRAR',
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
              TextFormField(
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
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}'))
                  ],
                  decoration: InputDecoration(
                    filled: true,
                  )),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                child: Center(
                  child: Row(
                    children: [
                      Expanded(
                          child: Text('TEMP:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ))),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextFormField(
                            onFieldSubmitted: (value) => _updateAttributes(
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
                                hintText: 'Skriv in löparens temperatur här...',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  'BLODTRYCK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 187, 205, 231),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.03),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01),
                          child: Row(
                            children: [
                              Spacer(),
                              Text('PULS:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  )),
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: TextFormField(
                                    onFieldSubmitted: (value) =>
                                        _updateAttributes(
                                            controllersMap, patientsModel),
                                    validator: (value1) {
                                      if (value1 == null || value1.isEmpty) {
                                        return 'Vänligen fyll i puls';
                                      }
                                      return null;
                                    },
                                    controller: pulseController,
                                    minLines: 1,
                                    maxLines: 1,
                                    keyboardType: Platform.isIOS
                                        ? TextInputType.numberWithOptions(
                                            signed: true, decimal: true)
                                        : TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      CommaFormatter(),
                                      FilteringTextInputFormatter.allow(RegExp(
                                        r'^[0-9]*',
                                      )),
                                    ],
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText:
                                            'Skriv in löparens puls här...',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))))),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01),
                          child: Row(
                            children: [
                              Spacer(),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
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
                                      hintText: 'Systole',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              RotationTransition(
                                turns: AlwaysStoppedAnimation(30 / 360),
                                child: Container(
                                    width: 4, height: 60, color: Colors.black),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
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
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "% SATS:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Spacer(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
                              Spacer(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "GLUKOS:",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                              Spacer(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
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
                              Spacer(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('ÖVRIGT:',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                        Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.01),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                      onFieldSubmitted: (value) =>
                                          _updateAttributes(
                                              controllersMap, patientsModel),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))))),
                                ])),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VitalPage()));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 61, 104, 129)),
                  child: const Text("+"),
                ),
              ),
            ],
          ),
        ));
  }
}
