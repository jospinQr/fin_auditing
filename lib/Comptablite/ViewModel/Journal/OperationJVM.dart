import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../Public/Constants/ApiConatants.dart' as publicApi;
import '../../Models/Journal/OperationM.dart';
import '../../Constants/ApiConstants.dart';
import 'package:http/http.dart' as http;

class OperationJVM with ChangeNotifier {
  //proprietes
  List<OperationM> _operationList = [];
  late OperationM _operation;

  //retourner une operation
  OperationM get getOperation => _operation;

  //modifier une peration
  void setOpera(OperationM operation1) {
    _operation = operation1;
    notifyListeners();
  }

  // returner une liste des operation
  List<OperationM> get itemOpera => _operationList;

  Future loadopItems(String dateOp, String codeSite, String codAn,
      String codeAgence, String observation) async {
    final String params =
        "dateopera=$dateOp&&codsite=$codeSite&&codan=$codAn&&codag=$codeAgence&&obsopera=$observation";
    final url = Uri.parse(
       publicApi.AipConstants.baseUrl + ApiConstants.Journaloperation + params);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _operationList = List<OperationM>.from(
        data.map((json) => OperationM.fromjson(json)),
      );
      notifyListeners();
    } else {
      throw 'Une erreur produite';
    }
  }

  Future loadopTypeItems(String dateOp, String codeSite, String codAn,
      String codeAgence, String type) async {
    final String params =
        "dateopera=$dateOp&&codsite=$codeSite&&codan=$codAn&&codag=$codeAgence&&typeopera=$type";
    final url = Uri.parse(
        publicApi.AipConstants.baseUrl+ ApiConstants.jounrnaloprationtype + params);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _operationList = List<OperationM>.from(
        data.map((json) => OperationM.fromjson(json)),
      );
      notifyListeners();
    } else {
      throw 'Une erreur produite';
    }
  }
}
