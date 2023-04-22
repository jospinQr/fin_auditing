import 'package:flutter/cupertino.dart';

class SousMassPrincipVM with ChangeNotifier{

  late String _code;
  late String _intitule;
  late  String _soldN;
  late  String _soldN1;


  String get getCodeSousMassPrincip => _code;

  void setCodeSousMassPrincip(String code) {
    _code=code;
    notifyListeners();
  }

  String get getIntili => _intitule;

  void setIntitueSousMassPrincip(String intitule) {
    _intitule = intitule;
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