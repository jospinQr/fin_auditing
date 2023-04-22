import 'dart:convert';


import 'package:fin_auditing/Comptablite/Constants/ApiConstants.dart';
import 'package:flutter/material.dart';

import '../../../Public/Constants/ApiConatants.dart' as publicApi;
import 'package:http/http.dart' as http;

import '../../Models/Journal/DateOpJ.dart';

class DateopJVM with ChangeNotifier {
  List<DateOJM> _dateop = [];

  List<DateOJM> get items => _dateop;

  Future loadDateItems(String codeSite,String codAn ,String codeAgence,String observation) async {
    final String params = "codsite=$codeSite&&codan=$codAn&&codag=$codeAgence&&obsopera=$observation";
    final url = Uri.parse(
       publicApi.AipConstants.baseUrl  + ApiConstants.Journaldateop+params);
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


  Future loadDateTypeItems(String type,String codAn,String codeAgence,String codeSite) async {
    final String params = "typeopera=$type&&codan=$codAn&&codag=$codeAgence&&codsite=$codeSite";
    final url = Uri.parse(
      publicApi.AipConstants.baseUrl + ApiConstants.journaldateopType+params);
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
