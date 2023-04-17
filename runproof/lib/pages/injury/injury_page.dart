import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:gbg_varvet/utils/info_popup.dart';
import 'package:gbg_varvet/pages/sickness/diag_page.dart';
import 'package:gbg_varvet/pages/utceck_page.dart';
import 'package:gbg_varvet/widgets/bottom_bar_widget.dart';

class InjuryPage extends StatefulWidget {
  const InjuryPage({super.key});

  @override
  _InjuryPageState createState() => _InjuryPageState();
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

class _InjuryPageState extends State<InjuryPage> {
  int radioValue = -1;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var patientsModel = context.watch<PatientsModel>();
    Map patient = patientsModel.activePatient;
    print("$patient");
    bool chafe = patient["injury"]["chafe"] ?? false;
    bool ankle = patient["injury"]["ankle"] ?? false;
    bool muscle = patient["injury"]["muscle"] ?? false;
    bool cramp = patient["injury"]["cramp"] ?? false;

    TextEditingController injuryComment =
        TextEditingController(text: patient["injuryComment"]);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          drawer: const DrawerWidget(title: "RunProof"),
          bottomNavigationBar: const BottomBarWidget(
            forwardText: "NÄSTA",
            title: "R",
            nextPage: UtcheckPage(),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 16, 47, 83),
            title: Image.asset('assets/images/runprooflogo.png',
                fit: BoxFit.cover,
                height:60),
            centerTitle: true,
            actions: [
              Row(
                children: [
                  Center(
                      child: ElevatedButton(
                        onPressed: () => SavePopup(context),
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Colors.green,
                            fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.2, 20)),
                        child: const Text("PAUSA"),
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
                    color: const Color.fromARGB(255, 187, 205, 231),
                    child: Padding(
                      padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.005),
                              child: const Text('SKADA',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                          const Divider(
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                chafe = !chafe;
                                patientsModel.setAttribute(
                                    "chafe", chafe, "injury");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: const Text('Skavsår',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: chafe
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                ankle = !ankle;
                                patientsModel.setAttribute(
                                    "ankle", ankle, "injury");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: const Text('Stukad fotled',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: ankle
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                muscle = !muscle;
                                patientsModel.setAttribute(
                                    "muscle", muscle, "injury");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: const Text('Muskelvärk',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: muscle
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                cramp = !cramp;
                                patientsModel.setAttribute(
                                    "cramp", cramp, "injury");
                              },
                            );
                          },
                          // ignore: sort_child_properties_last
                          child: const Text('Kramp',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: cramp
                                ? Color.fromARGB(255, 114, 194, 116)
                                : Color(0xFF94B0DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 5,
                        left: MediaQuery.of(context).size.width * 0.05,
                      ),
                      child: const Text('ÖVRIGT:',
                          style: TextStyle(color: Colors.black, fontSize: 18))),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 1, left: 15, right: 15),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                      onFieldSubmitted: (value) => patientsModel
                                          .setAttribute("injuryComment", value),
                                      controller: injuryComment,
                                      minLines: 2,
                                      maxLines: 6,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.multiline,
                                      decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Skriv något här...',
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))))),
                                ]),
                          ))),
                ],
              ))),
    );
  }
}
