import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import "package:gbg_varvet/pages/form_page.dart";
import "package:gbg_varvet/utils/utils.dart";
import "package:provider/provider.dart";
import "package:gbg_varvet/pages/injury/injury_page.dart";

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hej"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text("Vänligen välj en")),
          const SizedBox(
            height: 60,
          ),
          Center(
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
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.4,
                        60), // adjust button size based on screen width
                    // increase button size
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // add rounded corners
                    ),
                  ),
                  child: const Text("Skada")),
              SizedBox(
                width: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  var patientsModel = context.read<PatientsModel>();
                  patientsModel.setAttribute("type", "sickness");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FormPage()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.4,
                      60), // adjust button size based on screen width
                  // increase button size
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // add rounded corners
                  ),
                ),
                child: const Text("Sjukdom"),
              )
            ],
          )),
        ],
      ),
    );
  }
}
