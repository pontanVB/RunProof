import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import "package:gbg_varvet/utils/utils.dart";
import "package:provider/provider.dart";
import 'package:gbg_varvet/pages/sickness/vital_page.dart';
import 'package:gbg_varvet/pages/injury/injury_page.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('assets/images/runprooflogo.png',
            fit: BoxFit.cover, height: 60.0, width: 60.0),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 16, 47, 83),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Text("VÄNLIGEN VÄLJ TILLSTÅND",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold))),
          const SizedBox(height: 20, width: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0, top: 25),
            child: Divider(
              height: 10,
              thickness: 2,
              color: Colors.black,
              indent: 20,
              endIndent: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      var patientsModel = context.read<PatientsModel>();
                      patientsModel.setAttribute("type", "injury");

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InjuryPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.8, 180),
                      primary: Color.fromARGB(255, 181, 202,
                          233), // adjust button size based on screen width
                      // increase button size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // add rounded corners
                      ),
                    ),
                    child: const Text("SKADA",
                        style: TextStyle(color: Colors.black, fontSize: 30))),
              ],
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      var patientsModel = context.read<PatientsModel>();
                      patientsModel.setAttribute("type", "sickness");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VitalPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.8, 180),
                      primary: Color.fromARGB(255, 181, 202,
                          233), // adjust button size based on screen width
                      // increase button size
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // add rounded corners
                      ),
                    ),
                    child: const Text("SJUKDOM",
                        style: TextStyle(color: Colors.black, fontSize: 30)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
