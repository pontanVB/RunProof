import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// TODO: save data locally so it persists after restart

class PatientsModel with ChangeNotifier {
  int _activeIndex = 0;
  final List<Map> _patientsList = [];

  Map get activePatient => _patientsList[_activeIndex];

  set activeIndex(int index) {
    _activeIndex = index;
  }

  // getter for accessing patients map
  List<Map> get patientsList => _patientsList;

  void add(int newValue) {
    _activeIndex += newValue;
    notifyListeners();
  }

  void addPatient(Map newPatient) {
    _patientsList.add(newPatient);
    notifyListeners();
  }

  Map getPatient(int index) {
    return _patientsList[index];
  }
}
