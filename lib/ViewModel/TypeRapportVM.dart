import 'package:flutter/cupertino.dart';

class TypeRapportVM with ChangeNotifier{

  var rapportName="Journal Brouillard";

  String get getRapportName=>rapportName;

  void setRapportName(String rapportName){
    this.rapportName=rapportName;
    notifyListeners();
  }

}