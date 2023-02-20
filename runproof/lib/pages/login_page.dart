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
    return Scaffold(backgroundColor: const Color(0xFF1F4A7B),
        body: Center(
          child: ListView(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child:Image.asset('assets/images/logoTransparent.png'
                      ),
                    ),
                    const Expanded(child: Text('RunProof',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,
                        color: Color(0xFF94B0DA),
                      ),
                    ),
                    )
                  ],
                ),
                const Center (
                    child: Text('Användarnamn', textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,
                        color: Colors.white,
                      ),
                    )
                ),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 300,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: usernameController,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: " ",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(width: 2.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                    child: Text('Lösenord',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,
                        color: Colors.white,
                      ),
                    )
                ),
                Center(
                  child: SizedBox(
                    height: 60,
                    width: 300,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: passwordController,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                          hintText: " ",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: const BorderSide(width: 2.0, color: Colors.white),
                          ),
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
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width:150,
                    child: ElevatedButton(
                        onPressed: signUserIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF75C883), //background color of button
                          side: const BorderSide(width:1, color:Colors.white), //border width and color
                          elevation: 8, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                              borderRadius: BorderRadius.circular(15)
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        child: const Text(
                          'LOGGA IN',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,
                            color: Colors.white,
                          ),
                        )
                    ),
                  ),
                ),
              ]
          ),
        )
    );
  }

  void _togglePasswordView()
  {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

}
