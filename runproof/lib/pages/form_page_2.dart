import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:flutter/services.dart';

class FormPage2 extends StatefulWidget {
  const FormPage2({super.key});

  @override
  _FormPage2State createState() => _FormPage2State();
}

class _FormPage2State extends State<FormPage2> {
  bool isVal = false;
  bool isNotVal = false;
  bool isKon = false;
  bool isOko = false;
  bool isKra = false;
  bool isSal = false;
  bool isOver = false;
  bool isNotOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1F4A7B),
        drawer: DrawerWidget(title: "RunProof"),
        appBar: AppBar(
          title: Image.asset('assets/images/runprooflogo.png',
              fit: BoxFit.contain, height: 60),
          backgroundColor: Color.fromARGB(255, 142, 184, 223),
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
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
                                minLines: 1,
                                maxLines: 1,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
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
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                          isVal = value!;
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
                          isNotVal = value!;
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
                              isOver = value!;
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
                            "INGEN KÄND",
                            style: TextStyle(color: Colors.white),
                          ),
                          autofocus: false,
                          selected: false,
                          value: isNotOver,
                          onChanged: (bool? value) {
                            setState(() {
                              isNotOver = value!;
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

                // ElevatedButton(onPressed: sendData, child: const Text("Send data!")),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Navigate back to first route when tapped.
                //       Navigator.pop(context);
                //     },
                //     child: const Text('Go back!'),
                //   ),
                // ),
              ], //Column children
            ),
            Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 1),
                    child: Text('KOMMENTAR:',
                        style: TextStyle(color: Colors.white, fontSize: 18)))),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 108, 211, 92),
                            onPrimary: Colors.white),
                        child: const Text("NÄSTA"),
                      ),
                    )),
              ],
            )
          ],
        ));
  }
}
