import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/pages/form_page.dart';
import 'package:gbg_varvet/utils/info_popup.dart';
import "package:gbg_varvet/widgets/drawer_widget.dart";
import "package:gbg_varvet/utils/utils.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final User currentUser = FirebaseAuth.instance.currentUser!;
  final DatabaseReference ref = FirebaseDatabase.instance.ref("/users");
  final refreshTokenPromise = FirebaseAuth.instance.currentUser
      ?.getIdToken()
      .then((value) => print(value));

  final searchController = TextEditingController();

  String name = "";
  String age = "";

  void add() async {
    final String userId = currentUser.uid;
    Map<String, dynamic> data = {"name": "carro", "age": 18, "time": 10};
    ref.child("$userId/4").set(data);
  }

  void show() async {
    final String userId = currentUser.uid;
    final search = searchController.text;
    try {
      final snapshot = await ref.child("$userId/$search").get();
      if (snapshot.exists) {
        Map<dynamic, dynamic> map = snapshot.value as Map;

        String responseName = map["name"];

        setState(() {
          name = responseName;
          age = map["age"].toString();
        });
      } else {
        print('No data available.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Du är påväg att loggas ut'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Är du säker på att du vill logga ut?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text('Confirm'),
                onPressed: () {
                  signUserOut();
                  Navigator.of(context).pop();
                }),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1F4A7B),
        appBar: AppBar(
            title: Image.asset('assets/images/runprooflogo.png',
                fit: BoxFit.cover, height: 60.0, width: 60.0),
            centerTitle: true,
            backgroundColor: Color(0xFF94B0DA),
            actions: <Widget>[
              IconButton(
                  onPressed: _showMyDialog,
                  icon: const Icon(Icons.logout_outlined))
            ]),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('SÖK PATIENT:'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              TextField(
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.search),
                                      hintText: 'Namn eller personnummer')),
                            ],
                          ),
                          actions: <Widget>[
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF75C883)),
                                onPressed: () => Navigator.pop(context, 'SÖK'),
                                child: const Text('SÖK'),
                              ),
                            ),
                          ],
                        ),
                      )),
              Spacer(),
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const FormPage()));
                    var patients = context.read<PatientsModel>();
                    patients.add(1);
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt), onPressed: () {}),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Center(
            child: ListView(shrinkWrap: true, children: <Widget>[
          Text(name),
          Text(age),
          Center(child: Text(currentUser.email!)),
          const Center(
              child: Text(
            'Ange löparnummer manuellt',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          )),
          Padding(padding: EdgeInsets.all(7.0)),
          Center(
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    hintText: "Löparnummer"),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 150,
              child: ElevatedButton(
                  child: const Text('Lägg till'),
                  onPressed: () => runnerInfoPopup(
                      context, searchController.text), // showDialog<String>(
                  // context: context,
                  // builder: (BuildContext context) => AlertDialog(
                  //   title: const Text('Löparinformation:'),
                  //   content: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       const SizedBox(
                  //         height: 40,
                  //         child: TextField(
                  //             decoration: InputDecoration(
                  //           icon: Icon(Icons.content_copy),
                  //           hintText: 'Löparnummer',
                  //         )),
                  //       ),
                  //       SizedBox(
                  //         height: 40,
                  //         child: TextField(
                  //             decoration: InputDecoration(
                  //           icon: Icon(Icons.person),
                  //           hintText: 'Namn',
                  //         )),
                  //       ),
                  //       SizedBox(
                  //         height: 40,
                  //         child: TextField(
                  //             decoration: InputDecoration(
                  //           icon: Icon(Icons.numbers),
                  //           hintText: 'Personnummer',
                  //         )),
                  //       ),
                  //       SizedBox(
                  //         height: 40,
                  //         child: TextField(
                  //             decoration: InputDecoration(
                  //           icon: Icon(Icons.timer),
                  //           labelText: 'Ankomsttid...',
                  //         )),
                  //       ),
                  //     ],
                  //   ),
                  //   actions: <Widget>[
                  //     ElevatedButton(
                  //       child: Text("Lägg till"),
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) =>
                  //                     const FormPage()));
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: const Color(0xFF75C883),
                  //       ),
                  //     ),
                  //     ElevatedButton(
                  //         onPressed: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //         child: Text('Avbryt'),
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.redAccent))
                  //   ],
                  // ),

                  //child: const Text('Lägg till'),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  )),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                var patientsModel = context.read<PatientsModel>();
                patientsModel
                    .addPatient({"name": "hejsan", "runningNumber": 40});
              },
              child: const Text("lägg till")),
          Consumer<PatientsModel>(builder: (context, patients, child) {
            return Text("${patients.patientsList}");
          })
        ])),
        drawer: DrawerWidget(title: "HEj"));
  }
}
