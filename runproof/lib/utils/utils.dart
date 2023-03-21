import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Using shared_preferences here to store data locally so no patients get lost
// if the app crashes

class PatientsModel with ChangeNotifier {
  List<Map> _patientsList = [];
  int activeFormPage = 0;
  String _searchTerm = "";

  PatientsModel() {
    _loadDataFromPrefs();
  }

  int _activeIndex = 0;

  String get searchTerm => _searchTerm;

  set searchTerm(searchTerm) {
    _searchTerm = searchTerm;
    notifyListeners();
  }

  Map get activePatient => _patientsList[_activeIndex];

  int get activeIndex => _activeIndex;

  void setAttribute(String key, var attr, [String? nestedKey]) {
    nestedKey == null
        ? _patientsList[_activeIndex][key] = attr
        : _patientsList[_activeIndex][nestedKey][key] = attr;
    notifyListeners();
    _saveDataToPrefs();
  }

  void setActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  // getter for accessing patients map
  List<Map> get patientsList => _patientsList;

  void updateActivePatient(Map patient) {
    // if we update a key, we want to notify and save
    _patientsList[_activeIndex] = patient;
    //notifyListeners();
    _saveDataToPrefs();
  }

  void addPatient(Map newPatient) {
    print("added new patioent $newPatient");
    _patientsList.add(newPatient);
    _activeIndex = _patientsList.length - 1; // setting it to be active
    _addAttributes();
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
    //final patientsJson = jsonEncode(_patientsList);
    final patientsJson = json.encode(_patientsList);
    await prefs.setString('patients_list', patientsJson);
  }

  void _addAttributes() {
    // adding all attributes (keys)

    Map<String, dynamic> attributes = {
      "injury": <String, dynamic>{},
      "sickness": <String, dynamic>{},
      "filled_options": 0,
    };

    _patientsList[_activeIndex].addAll(attributes);
  }
}
