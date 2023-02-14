// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gbg_varvet/widgets/drawer_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool isVal = false;
  bool isKon = false;
  bool isOko = false;
  bool isKra = false;
  bool isSal = false;
  bool isOver = false;
  bool isBlod = false;
  bool isLake = false;
  bool isAna = false;
  bool test = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(title: "hej"),
      appBar: AppBar(title: Text("Formulär för 'insert person'")),
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: TextField(
              decoration: InputDecoration(hintText: "Tempratur °C"),
            ),
          ),
          CheckboxListTile(
            title: const Text("Vallad? "),
            autofocus: false,
            selected: isVal,
            value: isVal,
            onChanged: (bool? value) {
              setState(() {
                isVal = value!;
              });
            },
          ),
          Column(
            children: [
              Text('Status: '),
              CheckboxListTile(
                title: const Text("Konfusion: "),
                autofocus: false,
                selected: isKon,
                value: isKon,
                onChanged: (bool? value) {
                  setState(() {
                    isKon = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Okontaktbar: "),
                autofocus: false,
                selected: isOko,
                value: isOko,
                onChanged: (bool? value) {
                  setState(() {
                    isOko = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Kräkning: "),
                autofocus: false,
                selected: isKra,
                value: isKra,
                onChanged: (bool? value) {
                  setState(() {
                    isKra = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Saltpaket: "),
                autofocus: false,
                selected: isSal,
                value: isSal,
                onChanged: (bool? value) {
                  setState(() {
                    isSal = value!;
                  });
                },
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text("Överkänslig?: "),
                  autofocus: false,
                  selected: isOver,
                  value: isOver,
                  onChanged: (bool? value) {
                    setState(() {
                      isOver = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  enabled: isOver,
                ),
              ),
            ], //Row children
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text("Blodsmitta?: "),
                  autofocus: false,
                  selected: isBlod,
                  value: isBlod,
                  onChanged: (bool? value) {
                    setState(() {
                      isBlod = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  enabled: isBlod,
                ),
              ),
            ], //Row children
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text("Läkemedel?: "),
                  autofocus: false,
                  selected: isLake,
                  value: isLake,
                  onChanged: (bool? value) {
                    setState(() {
                      isLake = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  enabled: isLake,
                ),
              ),
            ], //Row children
          ),
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  title: const Text("Anames?: "),
                  autofocus: false,
                  selected: isAna,
                  value: isAna,
                  onChanged: (bool? value) {
                    setState(() {
                      isAna = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: TextField(
                  enabled: isAna,
                ),
              ),
            ], //Row children
          ),
          ElevatedButton(onPressed: sendData, child: const Text("Send data!")),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate back to first route when tapped.
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ),
        ], //Column children
      ),
    );
  }
}
