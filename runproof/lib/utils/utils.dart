import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Using shared_preferences here to store data locally so no patients get lost
// if the app crashes

class PatientsModel with ChangeNotifier {
  List<Map> _patientsList = [];

  PatientsModel() {
    _loadDataFromPrefs();
  }

  int _activeIndex = 0;

  Map get activePatient => _patientsList[_activeIndex];

  int get activeIndex => _activeIndex;

  void setActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  // getter for accessing patients map
  List<Map> get patientsList => _patientsList;

  void addPatient(Map newPatient) {
    print("added new patioent $newPatient");
    _patientsList.add(newPatient);
    _activeIndex = _patientsList.length - 1; // setting it to be active
    notifyListeners();
    _saveDataToPrefs();
  }

  Map getPatient(int index) {
    return _patientsList[index];
  }

  void removePatient(int index) {
    _patientsList.removeAt(index);
    notifyListeners();
    _saveDataToPrefs(); // OVERWRITE OLD
  }

  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final patientsList = prefs.getString('patients_list');

    if (patientsList != null) {
      // Convert the JSON string to your data model
      List<Map> patientsListEncoded =
          (json.decode(patientsList) as List<dynamic>).cast<Map>();

      // Update the state of your model
      _patientsList = patientsListEncoded;
      notifyListeners();
    }
  }

  Future<void> _saveDataToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final patientsJson = jsonEncode(_patientsList);
    await prefs.setString('patients_list', patientsJson);
  }
}
