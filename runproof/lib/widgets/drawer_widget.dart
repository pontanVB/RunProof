import 'package:flutter/material.dart';
import 'package:gbg_varvet/pages/injury/injury_page.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gbg_varvet/utils/db_functions.dart';
import "package:gbg_varvet/pages/form_page.dart";

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.title});

  final String title;

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Du är påväg att loggas ut'),
          content: SingleChildScrollView(
            child: Column(
              children: const <Widget>[
                Text('Är du säker på att du vill logga ut?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('Confirm'),
                onPressed: () {
                  signUserOut();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                }),
            TextButton(
              child: const Text('Cancel'),
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
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 220,
            child: DrawerHeader(
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                color: Color(0xFF1F4A7B),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Image.asset(
                      'assets/images/runprooflogo.png',
                    ),
                  ),
                  const Expanded(
                    flex: 6,
                    child: Text(
                      '  RunProof',
                      style: TextStyle(
                        fontSize: 30,
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
          ),
          Expanded(child: _PatientsList()),
          Center(
            child: FloatingActionButton.extended(
              heroTag: "test",
              extendedPadding: const EdgeInsets.all(20),
              onPressed: () => _showMyDialog(context),
              label: const Text('SIGN OUT'),
              icon: const Icon(Icons.logout),
              backgroundColor: const Color(0xFFAB1C48),
            ),
          ),
        ],
      ),
    );
  }
}

class _PatientsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This gets the current state of PatientsModel and also tells Flutter
    // to rebuild this widget when PatientsModel notifies listeners (in other words,
    // when it changes).
    var patientsList = context.watch<PatientsModel>();

    return ListView.builder(
        padding: const EdgeInsets.only(top: 0),
        itemCount: patientsList.patientsList.length,
        itemBuilder: (context, index) {
          final Map patient = patientsList.getPatient(index);

          final name = patient["name"];
          final runningNumber = patient["runningNumber"];

          return Card(
            child: ListTile(
              leading: CircularPercentIndicator(
                radius: 20,
                percent: 0.5,
                backgroundColor: Colors.black12,
                progressColor: const Color(0xFF75C883),
              ),
              title: Text('$name'.toUpperCase(), textScaleFactor: 1.4),
              subtitle: Text(
                '#$runningNumber',
                textScaleFactor: 1.2,
              ),
              trailing: (patientsList.activeIndex == index)
                  ? const Text('AKTIV',
                      style: TextStyle(
                          color: Color(0xFF75C883),
                          fontWeight: FontWeight.bold))
                  : null,
              onTap: () {
                patientsList.setActiveIndex(index);
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            patientsList.activePatient["type"] == "sickness"
                                ? const FormPage()
                                : const InjuryPage()));
              },
            ),
          );
        });
  }
}
