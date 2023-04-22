import 'package:flutter/cupertino.dart';

class TypeRapportVM with ChangeNotifier{

  //cette variable nous permet de savoir si on veut afficher quel type de journal
  //par defaut on est sur le journal brouillard
  var _rapportName="Journal Brouillard";
  //celle ci nous permet de distinguer le journal crhonologique du journal brouillard
  //par defau elle vaut 0(brouillard)
  var _observationJournal='0';

  var _typeJournal;


  //getter and settter pour nos variables ci-haut
  String get getTypeJournal=>_typeJournal;

   void setTypeJournal(String typeJournal){
            this._typeJournal=typeJournal;
  }

  String get getRapportName=>_rapportName;

  void setRapportName(String rapportName){
    this._rapportName=rapportName;
    notifyListeners();
  }

  String get getObservation=> _observationJournal;

  void setObservation(String observ){
    _observationJournal=observ;
  }


}