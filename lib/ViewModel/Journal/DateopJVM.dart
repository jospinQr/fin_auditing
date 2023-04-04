import 'dart:convert';

import 'package:fin_auditing/Models/Journal/DateOpJ.dart';
import 'package:flutter/material.dart';

import '../../Constants/ApiConstants.dart';
import 'package:http/http.dart' as http;

class DateopJVM with ChangeNotifier {
  List<DateOJM> _dateop = [];

  List<DateOJM> get items => _dateop;

  Future loadDateItems(String codeSite,String codAn ,String codeAgence) async {
    final String params = "codsite=$codeSite&&codan=$codAn&&codag=$codeAgence";
    final url = Uri.parse(
        ApiConstants.baseUrl + ApiConstants.Journaldateop+params);
    final response = await http.get(url);


    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _dateop = List<DateOJM>.from(
        data.map((json) => DateOJM.fromjson(json)),
      );
      notifyListeners();
    } else {
      throw 'Une erreur produite';
    }
  }
}
