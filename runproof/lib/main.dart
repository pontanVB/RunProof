import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gbg_varvet/pages/auth_page.dart';
import 'firebase_options.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: "App");

  runApp(ChangeNotifierProvider(
    create: (context) => PatientsModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 31, 74, 123),
        //brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 31, 74, 123),
        primarySwatch: Colors.blue,
        unselectedWidgetColor: Colors.white,
        // Define the default font family.
        //  fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
      ),
    );
  }
}
