import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:gbg_varvet/pages/form_page.dart';
import "package:gbg_varvet/widgets/drawer_widget.dart";

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
            title: Image.asset('Assets/runprooflogo.png',
                fit: BoxFit.cover, height: 60.0, width: 60.0),
            centerTitle: true,
            backgroundColor: Color(0xFF94B0DA),
            actions: <Widget>[
              IconButton(
                  onPressed: _showMyDialog,
                  icon: const Icon(Icons.logout_outlined))
            ]),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(name),
              Text(age),
              Center(child: Text(currentUser.email!)),
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
                        hintText: "Ange löparnummer"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Löparinformation:'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  TextField(
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.content_copy),
                                          hintText: 'Löparnummer',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.grey,
                                              )))),
                                  Padding(padding: EdgeInsets.all(7.0)),
                                  TextField(
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.person),
                                          hintText: 'Namn',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.grey,
                                              )))),
                                  Padding(padding: EdgeInsets.all(7.0)),
                                  TextField(
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.numbers),
                                          hintText: 'Personnummer',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.grey,
                                              )))),
                                  Padding(padding: EdgeInsets.all(7.0)),
                                  TextField(
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.timer),
                                          labelText: 'Ankomsttid...',
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0)),
                                              borderSide: BorderSide(
                                                width: 2.0,
                                                color: Colors.grey,
                                              )))),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          ),
                      child: const Text('Sök'),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                      )),
                ),
              )
            ],
          ),
        ),
        drawer: DrawerWidget(title: "HEj"));
  }
}
