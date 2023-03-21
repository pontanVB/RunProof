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
import 'package:gbg_varvet/pages/camera_page.dart';
import "package:gbg_varvet/widgets/add_patient.dart";

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
              Spacer(),
              IconButton(
                  icon: Icon(Icons.add),
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
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CameraPage()),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Center(
            child: ListView(shrinkWrap: true, children: <Widget>[
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
                  onPressed: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return Dialog(child: AddNewPatient());
                    //     });
                    runnerInfoPopup(context, searchController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  child: const Text('Lägg till')),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                var patientsModel = context.read<PatientsModel>();
                patientsModel.removePatient(0);
              },
              child: const Text("ta bort")),
        ])),
        drawer: DrawerWidget(title: "HEj"));
  }
}
