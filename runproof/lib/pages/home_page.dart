import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  HomePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  final User currentUser = FirebaseAuth.instance.currentUser!;
  final DatabaseReference ref = FirebaseDatabase.instance.ref();

  void add() async {
    ref.child("/users").set({
      "name": "John",
      "age": 18,
      "address": {"line1": "100 Mountain View"}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Center(child: Text(currentUser.email!)),
          Center(
              child: ElevatedButton(
                  onPressed: signUserOut, child: const Text("Sign out"))),
          Center(
              child: ElevatedButton(onPressed: add, child: const Text("Add"))),
        ],
      ),
    ));
    // return Scaffold(
    //     body: Center(
    //         child: ListView(
    //   children: <Widget>[
    //     ElevatedButton(onPressed: signUserOut, child: const Text("Sign out")),
    //     Text(currentUser.email!)
    //   ],
    // )));
  }
}
