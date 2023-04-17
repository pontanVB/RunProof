import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:gbg_varvet/utils/info_popup.dart';
import "package:gbg_varvet/widgets/drawer_widget.dart";
import "package:gbg_varvet/utils/utils.dart";
import "package:gbg_varvet/widgets/add_patient.dart";
import 'package:gbg_varvet/pages/camera_page.dart';

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
  // final refreshTokenPromise = FirebaseAuth.instance.currentUser
  //     ?.getIdToken()
  //     .then((value) => print(value));

  final searchController = TextEditingController();

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
    var patientModel = context.watch<PatientsModel>();
    final searchController =
        TextEditingController(text: patientModel.searchTerm);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        onVerticalDragEnd: (DragEndDetails details) =>
            FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: Image.asset('assets/images/runprooflogo.png',
                    fit: BoxFit.cover, height: 60.0, width: 60.0),
                centerTitle: true,
                backgroundColor: Color.fromARGB(255, 16, 47, 83),
                actions: <Widget>[
                  IconButton(
                      onPressed: _showMyDialog,
                      icon: const Icon(Icons.logout_outlined))
                ]),
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const FormPage()));
                        // var patients = context.read<PatientsModel>();
                      }),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.large(
                backgroundColor: Colors.grey,
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CameraPage()),
                  );
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: Center(
                child: ListView(shrinkWrap: true, children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0, top: 40),
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Center(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: 1),
                              child: Text('SKANNA LÖPARNUMMER',
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
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 187, 205, 231),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      const Center(
                          child: Text(
                        'Eller ange löparnummer manuellt',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      )),
                      Padding(padding: EdgeInsets.all(7.0)),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                              controller: searchController,
                              minLines: 1,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Skriv in löparnummer här...',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, top: 20),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: ElevatedButton(
                        onPressed: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return Dialog(child: AddNewPatient());
                          //     });
                          print("TEEEXT ${searchController.text}");
                          runnerInfoPopup(context, searchController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            primary: Color.fromARGB(255, 66, 190, 122)),
                        child: const Text(
                          'Lägg till',
                          style: TextStyle(fontSize: 20),
                        )),
                  ),
                ),
              ),
            ])),
            drawer: DrawerWidget(title: "Hej")));
  }
}
