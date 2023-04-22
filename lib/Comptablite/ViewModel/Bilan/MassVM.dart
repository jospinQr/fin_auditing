import 'package:flutter/cupertino.dart';

class MassVM with ChangeNotifier {
  //fields

  late String _codeMass;
  late String _intitule;
  late String _soldN;
  late String _soldN1;

  //getter and setter

  String get getCodeMass => _codeMass;

  void setCodeMass(String codeMass) {
    _codeMass = codeMass;
  }

  String get getIntituleMass => _intitule;

  void setIntitule(String initutle) {
    _intitule = _intitule;
    notifyListeners();
  }

  String get getSoldN => _soldN;

  void setSoldN(String soldn) {
    _soldN = soldn;
    notifyListeners();
  }

  String get getSoldn1 => _soldN1;

  void setSoldn1(String soldN1) {
    _soldN1 = soldN1;
    notifyListeners();
  }
}
