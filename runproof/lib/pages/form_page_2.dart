import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/pages/form_page3.dart';

class FormPage2 extends StatefulWidget {
  const FormPage2({super.key});

  @override
  _FormPage2State createState() => _FormPage2State();
}

class _FormPage2State extends State<FormPage2> {
  bool isBlod = false;
  bool isNotBlod = false;
  bool isLak = false;
  bool isNotLak = false;
  bool isTid = false;
  bool isAst = false;
  bool isHyp = false;
  bool isDia = false;

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
                children: const [
                  Expanded(
                      child: Text('BLODSMITTA:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text(
                        "INGEN KÄND",
                        style: TextStyle(color: Colors.white),
                      ),
                      autofocus: false,
                      selected: false,
                      value: isNotBlod,
                      onChanged: (bool? value) {
                        setState(() {
                          isBlod = value! ? false : true;
                          isNotBlod = value;
                        });
                      },
                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text(
                        "JA",
                        style: TextStyle(color: Colors.white),
                      ),
                      autofocus: false,
                      selected: false,
                      value: isBlod,
                      onChanged: (bool? value) {
                        setState(() {
                          isNotBlod = value! ? false : true;
                          isBlod = value;
                        });
                      },
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
            ),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 1),
                    child: Text('KOMMENTAR:',
                        style: TextStyle(color: Colors.white, fontSize: 18)))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 19.0, bottom: 1, left: 15, right: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                minLines: 4,
                                maxLines: 6,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Skriv något här...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))))),
                          ]))),
            ),
            // ignore: prefer_const_constructors
            Divider(
              height: 10,
              thickness: 2,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: const [
                  Expanded(
                      child: Text('LÄKEMEDEL:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 45, right: 45),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text(
                        "NEJ",
                        style: TextStyle(color: Colors.white),
                      ),
                      autofocus: false,
                      selected: false,
                      value: isNotLak,
                      onChanged: (bool? value) {
                        setState(() {
                          isLak = value! ? false : true;
                          isNotLak = value;
                        });
                      },
                      activeColor: Colors.red,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text(
                        "JA",
                        style: TextStyle(color: Colors.white),
                      ),
                      autofocus: false,
                      selected: false,
                      value: isLak,
                      onChanged: (bool? value) {
                        setState(() {
                          isNotLak = value! ? false : true;
                          isLak = value;
                        });
                      },
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                ],
              ),
            ),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 1),
                    child: Text('KOMMENTAR:',
                        style: TextStyle(color: Colors.white, fontSize: 18)))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 19.0, bottom: 1, left: 15, right: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                minLines: 4,
                                maxLines: 6,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Skriv något här...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))))),
                          ]))),
            ),
            const Divider(
              height: 10,
              thickness: 2,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [
                  Expanded(
                      child: Text('ANAMNES:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, bottom: 8, left: 50, right: 60),
              child: Column(
                children: [
                  CheckboxListTile(
                    title: const Text(
                      "TID. VÄS. FRISK ",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    autofocus: false,
                    selected: false,
                    value: isTid,
                    onChanged: (bool? value) {
                      setState(() {
                        isTid = value!;
                      });
                    },
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                  CheckboxListTile(
                    title: const Text(
                      "ASTMA",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    autofocus: false,
                    selected: false,
                    value: isAst,
                    onChanged: (bool? value) {
                      setState(() {
                        isAst = value!;
                      });
                    },
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                  CheckboxListTile(
                    title: const Text(
                      "HYPERTONI",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    autofocus: false,
                    selected: false,
                    value: isHyp,
                    onChanged: (bool? value) {
                      setState(() {
                        isHyp = value!;
                      });
                    },
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                  CheckboxListTile(
                    title: const Text(
                      "DIABETES",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    autofocus: false,
                    selected: false,
                    value: isDia,
                    onChanged: (bool? value) {
                      setState(() {
                        isDia = value!;
                      });
                    },
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                  ),
                ],
              ),
            ),
            const Center(
                child: Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 1),
                    child: Text('KOMMENTAR:',
                        style: TextStyle(color: Colors.white, fontSize: 18)))),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 19.0, bottom: 1, left: 15, right: 15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                                minLines: 4,
                                maxLines: 6,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: 'Skriv något här...',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))))),
                          ]))),
            ),
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FormPage3()));
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
        ));
  }
}
