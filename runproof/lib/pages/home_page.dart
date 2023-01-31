import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:gbg_varvet/pages/form_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("front page")),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(name),
              Text(age),
              Center(child: Text(currentUser.email!)),
              Center(
                  child: ElevatedButton(
                      onPressed: signUserOut, child: const Text("Sign out"))),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FormPage()));
                      },
                      child: const Text("Add"))),
              Center(
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(hintText: "Enter number"),
                ),
              ),
              ElevatedButton(onPressed: show, child: const Text("search"))
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
