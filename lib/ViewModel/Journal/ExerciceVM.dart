import 'package:flutter/cupertino.dart';

class ExerciceVM with ChangeNotifier{

    late  String annee;


    String get getAnnee=>annee;

    void setanne(String annee){
        this.annee=annee;

    }



}