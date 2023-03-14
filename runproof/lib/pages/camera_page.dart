import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import "package:provider/provider.dart";
import "package:gbg_varvet/utils/utils.dart";
import 'package:gbg_varvet/widgets/drawer_widget.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  final String title = 'Scan';

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  String text = "";
  final StreamController<String> controller = StreamController<String>();

  void setText(value) {
    controller.add(value);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var patientModel = context.watch<PatientsModel>();
    late String currentText;

    return Scaffold(
        backgroundColor: const Color(0xFF1F4A7B),
        drawer: const DrawerWidget(title: "RunProof"),
        appBar: AppBar(
          title: Image.asset('assets/images/runprooflogo.png',
              fit: BoxFit.contain, height: 60),
          backgroundColor: const Color.fromARGB(255, 142, 184, 223),
        ),
        body: Column(
          children: <Widget>[
            ScalableOCR(
                paintboxCustom: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 4.0
                  ..color = const Color.fromARGB(153, 102, 160, 241),
                boxLeftOff: 1,
                boxBottomOff: 15,
                boxRightOff: 15,
                boxTopOff: 10000,
                boxHeight: MediaQuery.of(context).size.height / 1.5,
                getRawData: (value) {
                  inspect(value);
                },
                getScannedText: (value) {
                  setText(value);}
            ),
            Center(
              child:
                StreamBuilder<String>(
                  stream: controller.stream,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    currentText = snapshot.data != null ? snapshot.data! : "";
                    currentText = currentText.replaceAll(RegExp(r'[^0-9]'),'');
                    return Result(text: currentText);
                },)
            ),
            Center(
              child:
                ElevatedButton(
                    onPressed: () {
                      patientModel.searchTerm = currentText;
                      Navigator.pop(context); },
                    child: const Text("Acceptera resultat",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      )
                    )
                ),
            ),
          ],
        ),
      );
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Row(
        children: [
          const Text(
          "Nr: ",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "$text",
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
      ])
    );
  }
}