import 'package:flutter/cupertino.dart';

class TypeRapportVM with ChangeNotifier{

  //cette variable nous permet de savoir si on veut afficher quel type de journal
  //par defaut on est sur le journal brouillard
  var rapportName="Journal Brouillard";
  //celle ci nous permet de distinguer le journal crhonologique du journal brouillard
  //par defau elle vaut 0(brouillard)
  var observationJournal='0';


  //getter and settter pour nos variables ci-haut
  String get getRapportName=>rapportName;

  void setRapportName(String rapportName){
    this.rapportName=rapportName;
    notifyListeners();
  }

  String get getObservation=> observationJournal;

  void setObservation(String observ){
    observationJournal=observ;
  }


}