import 'package:flutter/cupertino.dart';

class NatureVM with ChangeNotifier{

  late String _designation;
  late String _soldN;
  late String _soldN1;

  String get getDesignation=>_designation;

  void setDesignation(String designation){
      _designation=designation;
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