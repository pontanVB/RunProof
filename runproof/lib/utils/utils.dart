import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Using shared_preferences here to store data locally so no patients get lost
// if the app crashes

class PatientsModel with ChangeNotifier {
  List<Map> _patientsList = [];
  String _searchTerm = "";
  int activeFormPage = 0;

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
    _activeIndex = 0;
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
    print(_patientsList);
    final prefs = await SharedPreferences.getInstance();
    final patientsJson = json.encode(_patientsList);
    await prefs.setString('patients_list', patientsJson);
  }

  void _addAttributes() {
    // adding all attributes (keys)
    Map currentPatient = _patientsList[_activeIndex];

    //if the patient is already registrered, we add a map for the missing injury/sickness map
    if (!currentPatient.containsKey("injury") &&
        !currentPatient.containsKey("sickness")) {
      Map<String, dynamic> attributes = {
        "injury": <String, dynamic>{},
        "sickness": <String, dynamic>{},
      };

      _patientsList[_activeIndex].addAll(attributes);
    }
    if (!currentPatient.containsKey("injury")) {
      _patientsList[activeIndex]["injury"] = {};
    }
    if (!currentPatient.containsKey("sickness")) {
      _patientsList[activeIndex]["sickness"] = {};
    }
  }
}

Map renameAttributes(Map patient, {bool fromDatabase = false}) {
  print(patient);
  if (fromDatabase) {
    // convert from "pretty names" to dev names
    Map changedMap = {"sickness": {}, "injury": {}};
    Map<String, dynamic> convertMap = {
      "skada": {
        "kramp": "cramp",
        "muskelvärk": "muscle",
        "stukad fotled": "ankle",
        "skavsår": "chafe"
      },
      "sjukdom": {
        "puls": "pulse",
        "blodtryck": "bloodPressure",
        "glukos": "glucose",
        "intravenös vätska": "intravenousFluid",
        "glukos givet": "givenGlucose",
        "andningssvårigheter": "breathingDifficulty",
        "bröstsmärta": "chestPain",
        "buksmärta": "stomachAche",
        "svimning": "fainted",
        "sysytole": "sysytole",
        "diastole": "diastole",
        "sats": "sats",
        "benso": "benso",
        "temp": "temp",
        "inhalation": "inhalation",
        "blodtryckskommentar": "bloodPressureComment",
      },
      "fortsätter loppet": "continueing",
      "löparnummer": "runningNumber",
      "fortsätter till sjukhus": "hospital",
      "fortsätter hem": "goingHome",
      "ålder": "age",
      "kön": "sex",
      "starttid": "startTime",
      "sluttid": "endTime"
    };
    patient.forEach((key, value) {
      if (convertMap.containsKey(key)) {
        if (value is Map) {
          value.forEach((innerKey, innerValue) {
            String renamedAttribute = convertMap[key][innerKey];
            String newKey = (key == "sjukdom") ? "sickness" : "injury";
            changedMap[newKey][renamedAttribute] = innerValue;
          });
        } else {
          changedMap[convertMap[key]] = value;
        }
      } else {
        changedMap[key] = value;
      }
    });

    return changedMap;
  } else {
    Map changedMap = {"sjukdom": {}, "skada": {}};
    Map<String, dynamic> convertMap = {
      "injury": {
        "cramp": "kramp",
        "muscle": "muskelvärk",
        "ankle": "stukad fotled",
        "chafe": "skavsår"
      },
      "sickness": {
        "pulse": "puls",
        "bloodPressure": "blodtryck",
        "bloodPressureComment": "blodtryckskommentar",
        "glucose": "glukos",
        "intravenousFluid": "intravenös vätska",
        "givenGlucose": "glukos givet",
        "breathingDifficulty": "andningssvårigheter",
        "chestPain": "bröstsmärta",
        "stomachAche": "buksmärta",
        "fainted": "svimning",
        "sysytole": "sysytole",
        "diastole": "diastole",
        "sats": "sats",
        "benso": "benso",
        "temp": "temp",
        "inhalation": "inhalation"
      },
      "continueing": "fortsätter loppet",
      "runningNumber": "löparnummer",
      "hospital": "fortsätter till sjukhus",
      "goingHome": "fortsätter hem",
      "age": "ålder",
      "sex": "kön",
      "startTime": "starttid",
      "endTime": "sluttid"
    };
    patient.forEach((key, value) {
      if (convertMap.containsKey(key)) {
        if (value is Map) {
          value.forEach((innerKey, innerValue) {
            String renamedAttribute = convertMap[key][innerKey];
            String newKey = (key == "sickness") ? "sjukdom" : "skada";

            changedMap[newKey][renamedAttribute] = innerValue;
          });
        } else {
          changedMap[convertMap[key]] = value;
        }
      } else {
        changedMap[key] = value;
      }
    });

    return changedMap;
  }
}
