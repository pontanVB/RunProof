import 'package:flutter/material.dart';
import 'package:gbg_varvet/utils/utils.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 250,
                child: DrawerHeader(
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
            ],
          ),
          // child: Column(
          //   // Important: Remove any padding from the ListView.
          //   children: [
          //     SizedBox(
          //       height: 250,
          //       child: DrawerHeader(
          //         decoration: const BoxDecoration(
          //           color: Color(0xFF1F4A7B),
          //         ),
          //         child: Row(
          //           children: [
          //             Expanded(
          //               flex: 4,
          //               child: Image.asset(
          //                 'assets/images/runprooflogo.png',
          //               ),
          //             ),
          //             const Expanded(
          //               flex: 6,
          //               child: Text(
          //                 '  RunProof',
          //                 style: TextStyle(
          //                   fontSize: 30,
          //                   color: Color(0xFF94B0DA),
          //                   shadows: <Shadow>[
          //                     Shadow(
          //                       offset: Offset(3, 3),
          //                       blurRadius: 3,
          //                       color: Colors.black54,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     ListTile(
          //       tileColor: const Color(0xFF94B0DA),
          //       title: const Text(
          //         'TÄLT X',
          //         textScaleFactor: 2,
          //         textAlign: TextAlign.center,
          //         style: TextStyle(color: Color(0xFF1F4A7B)),
          //       ),
          //       onTap: () {
          //         // Update the state of the app
          //         // ...
          //         // Then close the drawer
          //         Navigator.pop(context);
          //       },
          //     ),
          //     ListTile(
          //       leading: const Icon(
          //         Icons.check_circle,
          //         color: Color(0xFF75C883),
          //         size: 30,
          //       ),
          //       title: const Text(
          //         'Ingrid #44844',
          //         textScaleFactor: 1.5,
          //         style: TextStyle(color: Color(0xFF06192F)),
          //       ),
          //       onTap: () {
          //         // Update the state of the app
          //         // ...
          //         // Then close the drawer
          //         Navigator.pop(context);
          //       },
          //     ),
          //     ListTile(
          //       leading: const Icon(
          //         Icons.star,
          //         color: Color(0xFFD9D9D9),
          //         size: 30,
          //       ),
          //       title: const Text(
          //         'HÄLSODEKLARATION',
          //         textScaleFactor: 1.5,
          //         style: TextStyle(color: Color(0xFF06192F)),
          //       ),
          //       onTap: () {
          //         // Update the state of the app
          //         // ...
          //         // Then close the drawer
          //         Navigator.pop(context);
          //       },
          //     ),
          //     ListTile(
          //       leading: const Icon(
          //         Icons.star,
          //         color: Color(0xFFD9D9D9),
          //         size: 30,
          //       ),
          //       title: const Text(
          //         'HÄLSODEKLARATION',
          //         textScaleFactor: 1.5,
          //         style: TextStyle(color: Color(0xFF06192F)),
          //       ),
          //       onTap: () {
          //         // Update the state of the app
          //         // ...
          //         // Then close the drawer
          //         Navigator.pop(context);
          //       },
          //     ),
          //     ListTile(
          //       leading: const Icon(
          //         Icons.star,
          //         color: Color(0xFFD9D9D9),
          //         size: 30,
          //       ),
          //       title: const Text(
          //         'HÄLSODEKLARATION',
          //         textScaleFactor: 1.5,
          //         style: TextStyle(color: Color(0xFF06192F)),
          //       ),
          //       onTap: () {
          //         // Update the state of the app
          //         // ...
          //         // Then close the drawer
          //         Navigator.pop(context);
          //       },
          //     ),
          //     SizedBox(
          //       height: 40,
          //       width: 280,
          //       child: TextField(
          //         textAlign: TextAlign.left,
          //         style: const TextStyle(
          //           fontSize: 20,
          //           color: Colors.black,
          //         ),
          //         decoration: InputDecoration(
          //           prefixIcon: const Icon(Icons.search),
          //           hintText: "Sök",
          //           filled: true,
          //           fillColor: Colors.white,
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(15.0),
          //               borderSide:
          //                   const BorderSide(width: 2, color: Colors.black)),
          //         ),
          //       ),
          //     ),
          //     ElevatedButton(
          //         onPressed: () => print("sign out"),
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor:
          //               const Color(0xFFAB1C48), //background color of button
          //           elevation: 10, //elevation of button
          //           shape: RoundedRectangleBorder(
          //               //to set border radius to button
          //               borderRadius: BorderRadius.circular(15)),
          //           padding: const EdgeInsets.only(
          //               left: 20, right: 20, top: 10, bottom: 10),
          //         ),
          //         child: const Text(
          //           "LOGGA UT",
          //           style: TextStyle(color: Colors.white, fontSize: 20),
          //         ))

          //     //ListTile(
          //     //title: const Text('Item 2'),
          //     //onTap: () {
          //     //Navigator.push(
          //     //context,
          //     //MaterialPageRoute(builder: (context) => TextRecognitionPage())
          //     //);

          //     //},
          //     //),
          //   ],
          // ),
        ),
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
        itemCount: patientsList.patientsList.length + 1,
        itemBuilder: (context, index) {
          if (index == patientsList.patientsList.length) {
            // button
            return Container(
                child: ElevatedButton(
                    onPressed: () => print("sign out"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFAB1C48), //background color of button
                      elevation: 10, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                    ),
                    child: const Text(
                      "LOGGA UT",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )));
          } else {
            final Map patient = patientsList.getPatient(index);

            final name = patient["name"];
            final runningNumber = patient["runningNumber"];

            return ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Color(0xFF75C883),
                size: 30,
              ),
              title: Text('$name #$runningNumber',
                  textScaleFactor: 1.5,
                  style: const TextStyle(color: Color(0xFF06192F))),
              onTap: () {
                print(index);
                patientsList.activeIndex = index;
              },
            );
          }
        });
  }
}

class PatientListTile extends StatelessWidget {
  const PatientListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
