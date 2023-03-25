import 'dart:convert';
import 'package:flutter/material.dart';
import '../../Models/AgenceM.dart';
import '../ApiServices/ApiConstants.dart';
import 'package:http/http.dart' as http;

class AgenceJVM with ChangeNotifier {
  List<Agence> _agence = [];

  List<Agence> get items => _agence;


  Future loadAgenceItems() async {
    final url = Uri.parse(ApiConstants.baseUrl+ApiConstants.Journalgroupagence );
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