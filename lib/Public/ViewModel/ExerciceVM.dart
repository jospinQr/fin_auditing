import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../../Comptablite/Constants/ApiConstants.dart';
import '../Constants/ApiConatants.dart';
import '../../Comptablite/Models/ExerciceM.dart';
import 'package:http/http.dart' as http;

class ExerciceVM with ChangeNotifier {

  //proprietés
  List<ExerciceM> _exerciceList = [];
  late String _annee="";
  late String _dateDebut;
  late String _dateFin;

  //getters
  String get getAnnee => _annee;
  String get getDateDebut => _dateDebut;
  String get getDateFin => _dateFin;
  List<ExerciceM> get items => _exerciceList;

  //setters
  void setanne(String annee) {
    this._annee = annee;
  }
  void setDateDebut(String date) {
    _dateDebut = date;
  }
  void setDateFin(String date) {
    _dateFin = date;
  }


  Future loadListeExercice() async {
    final url = Uri.parse(AipConstants.baseUrl+ApiConstants.exerciceEndPoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _exerciceList = List<ExerciceM>.from(
        data.map(
          (json) => ExerciceM.fromjson(json),
        ),
      );
      notifyListeners();
    }
    else{
      throw 'echec de chargement';
    }
  }
}
