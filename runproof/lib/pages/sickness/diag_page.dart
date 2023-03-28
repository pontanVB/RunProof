// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/pages/sickness/behandling_page.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import "package:provider/provider.dart";
import 'package:flutter/services.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/pages/utceck_page.dart';

class DiagPage extends StatefulWidget {
  const DiagPage({super.key});

  @override
  _DiagPageState createState() => _DiagPageState();
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

class _DiagPageState extends State<DiagPage> {
  bool isAnd = true;
  bool isBrost = true;
  bool isBuk = true;
  bool isSvim = true;

  int radioValue = -1;

  final _formKey = GlobalKey<FormState>();

  final List<Map> myProducts =
      List.generate(100000, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;
    print("$patient");
    TextEditingController diagKommentar =
        TextEditingController(text: patient["diagnos"]);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: DrawerWidget(title: "RunProof"),
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset('assets/images/runprooflogo.png',
                fit: BoxFit.contain, height: 60),
            backgroundColor: Color.fromARGB(255, 16, 47, 83),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 10),
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 1),
                                  child: Text('HUVUDDIAGNOS',
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
                        width: 350,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                isAnd = !isAnd;
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Andningssvårighet',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: isAnd
                                ? Color(0xFF94B0DA)
                                : Color.fromARGB(255, 114, 194, 116),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                isBrost = !isBrost;
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Bröstsmärta',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: isBrost
                                ? Color(0xFF94B0DA)
                                : Color.fromARGB(255, 114, 194, 116),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                isBuk = !isBuk;
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Buksmärta',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: isBuk
                                ? Color(0xFF94B0DA)
                                : Color.fromARGB(255, 114, 194, 116),
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
                        width: 350,
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                isSvim = !isSvim;
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: Text('Svimning',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: isSvim
                                ? Color(0xFF94B0DA)
                                : Color.fromARGB(255, 114, 194, 116),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10, left: 30),
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
                                        .setAttribute("diagnos", value),
                                    controller: diagKommentar,
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
                                              const UtcheckPage()))
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
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
