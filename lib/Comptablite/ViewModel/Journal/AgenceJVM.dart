import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../Public/Models/AgenceM.dart';
import '../../../Public/Constants/ApiConatants.dart';
import 'package:http/http.dart' as http;

class AgenceJVM with ChangeNotifier {


  List<Agence> _agence = [];
  List<Agence> get items => _agence;

  //getter and setters
  late String _codeAgence;
  String get getCodeAgence=>_codeAgence;

  void setCodAge(String codeAgence) {
    _codeAgence = codeAgence;
  }

  Future loadAgenceItems(String urlEndPoint) async {
    final url =
        Uri.parse(AipConstants.baseUrl + urlEndPoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {


      final data = json.decode(response.body);
      _agence = List<Agence>.from(
        data.map((json) => Agence.fromjson(json)),
      );
      notifyListeners();
    } else {
      throw 'Une erreur produite';
    }
  }
}
