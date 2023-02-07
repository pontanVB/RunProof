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

  bool _isHidden = true;

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
            decoration: const InputDecoration(
                hintText: "Enter email"),
          ),
        ),
        Center(
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Enter password",
              suffix: InkWell(
                onTap: _togglePasswordView,
                child: Icon(
                  _isHidden ? Icons.visibility_off : Icons.visibility,
                ),
              )
            ),

            obscureText: _isHidden,
            enableSuggestions: false,
            autocorrect: false,

          ),
        ),
        ElevatedButton(onPressed: signUserIn, child: const Text('sign in')),
      ]),
    ));
  }

  void _togglePasswordView()
  {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

}
