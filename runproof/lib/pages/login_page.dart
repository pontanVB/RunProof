import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text, password: passwordController.text);
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        print("felmeddelande");
      }
    }
    //
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ListView(shrinkWrap: true, children: <Widget>[
        Center(
          child: TextField(
            controller: usernameController,
            decoration: InputDecoration(hintText: "Enter email"),
          ),
        ),
        Center(
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(hintText: "Enter password"),
          ),
        ),
        ElevatedButton(onPressed: signUserIn, child: const Text('sign in')),
      ]),
    ));
  }
}
