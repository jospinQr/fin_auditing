import 'package:flutter/material.dart';

class CompteVM with ChangeNotifier {

  late String _numCompte;
  late String _intitCompte;

  String get getNumCompte => _numCompte;

  String get getInitCompte => _intitCompte;

  void setNumCompte(String numCompte) {
    _numCompte = numCompte;
  }

  void setIntitCompte(String intitCompte) {
    _intitCompte = intitCompte;
  }
}



