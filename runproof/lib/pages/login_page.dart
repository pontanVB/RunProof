import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

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
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();

      if (error.code == "user-not-found") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                icon: Icon(Icons.warning_amber_sharp, size: 70),
                iconColor: Colors.red,
                title: Text("Oops!"),
                content:
                    Text('Ange en giltig email och lösenord för att logga in'),
                actions: [
                  Center(
                    child: ElevatedButton(
                        child: Text("Ok"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF75C883)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              );
            });
      } else if (error.code == "wrong-password") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                icon: Icon(Icons.warning_amber_sharp, size: 70),
                iconColor: Colors.red,
                title: Text("Oops!"),
                content: Text('Ange ett giltigt lösenord för att logga in'),
                actions: [
                  Center(
                    child: ElevatedButton(
                        child: Text("Ok"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF75C883)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              );
            });
      } else if (usernameController.text.isEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                icon: Icon(Icons.warning_amber_sharp, size: 70),
                iconColor: Colors.red,
                title: Text("Oops!"),
                content: Text('Ange en giltig email för att logga in'),
                actions: [
                  Center(
                    child: ElevatedButton(
                        child: Text("Ok"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF75C883)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              );
            });
      } else if (passwordController.text.isEmpty) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                icon: Icon(Icons.warning_amber_sharp, size: 70),
                iconColor: Colors.red,
                title: Text("Oops!"),
                content: Text('Ange ett giltigt lösenord för att logga in'),
                actions: [
                  Center(
                    child: ElevatedButton(
                        child: Text("Ok"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF75C883)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      onVerticalDragEnd: (DragEndDetails details) =>
          FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: const Color(0xFF1F4A7B),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: DropShadowImage(
                              offset: const Offset(3, 3),
                              scale: 1,
                              blurRadius: 5,
                              borderRadius: 3,
                              image: Image.asset(
                                'assets/images/runprooflogo.png',
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 6,
                            child: Text(
                              'RunProof',
                              style: TextStyle(
                                fontSize: 52,
                                color: Color(0xFF94B0DA),
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(3, 3),
                                    blurRadius: 3,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: const [
                          Expanded(child: Spacer()),
                          Expanded(
                              flex: 5,
                              child: Text(
                                'Användarnamn',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              )),
                          Expanded(child: Spacer()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          const Expanded(child: Spacer()),
                          Expanded(
                              flex: 5,
                              child: TextField(
                                textAlign: TextAlign.left,
                                controller: usernameController,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: "e-mail",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              )),
                          const Expanded(child: Spacer()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: const [
                          Expanded(child: Spacer()),
                          Expanded(
                              flex: 5,
                              child: Text(
                                'Lösenord',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              )),
                          Expanded(child: Spacer()),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        children: [
                          const Expanded(child: Spacer()),
                          Expanded(
                            flex: 5,
                            child: TextField(
                              textAlign: TextAlign.left,
                              controller: passwordController,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                  hintText: "* * * * *",
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  suffix: InkWell(
                                    onTap: _togglePasswordView,
                                    child: Icon(
                                      _isHidden
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  )),
                              obscureText: _isHidden,
                              enableSuggestions: false,
                              autocorrect: false,
                            ),
                          ),
                          const Expanded(child: Spacer())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        children: [
                          const Expanded(child: Spacer()),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                                onPressed: signUserIn,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFF75C883), //background color of button
                                  elevation: 10, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.all(10),
                                ),
                                child: const Text(
                                  'LOGGA IN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                          const Expanded(child: Spacer())
                        ],
                      ),
                    )
                  ]),
            ),
          )),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
