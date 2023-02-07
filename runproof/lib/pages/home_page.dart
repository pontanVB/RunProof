import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
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
        appBar: AppBar(
            title: const Text("home page")
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Text(name),
              Text(age),
              Center(child: Text(currentUser.email!)),
              Center(
                  child: ElevatedButton(
                      onPressed: signUserOut, child: const Text("Sign out")
                  )
              ),
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
                  decoration: const InputDecoration(hintText: "Ange löparnummer"),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
              ),
              ElevatedButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Löparinformation:'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        TextField(decoration: InputDecoration(
                            icon: Icon(Icons.content_copy),
                            hintText: 'Löparnummer',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 2.0, color: Colors.grey,
                                )
                            )
                        )
                        ),
                        Padding(padding: EdgeInsets.all(7.0)),
                        TextField(decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Namn',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 2.0, color: Colors.grey,
                                )
                            )
                        )
                        ),
                        Padding(padding: EdgeInsets.all(7.0)),
                        TextField(decoration: InputDecoration(
                            icon: Icon(Icons.numbers),
                            hintText: 'Personnummer',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(width: 2.0, color: Colors.grey,
                                )
                            )
                        )
                        ),
                        Padding(padding: EdgeInsets.all(7.0)),
                        TextField(decoration: InputDecoration(
                            icon: Icon(Icons.timer),
                            labelText: 'Ankomsttid...',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(width: 2.0, color: Colors.grey,
                            )
                            )
                        )
                        ),
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
                child: const Text('Search'),
              )
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.blue,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text('R U N P R O O F', style: TextStyle(fontSize: 35, color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                  ),
                ),
                ListTile(
                  title: const Text('Item'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Form page'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FormPage()),
                    );
                  },
                ),
              ],
            ),
          )
        ),
    );
  }
}
