import 'dart:convert';
import 'dart:developer';

import 'package:fin_auditing/Models/JounarlM.dart';
import 'package:flutter/material.dart';


import '../ApiServices/ApiConstants.dart';
import 'package:http/http.dart' as http;

class JournalVM with ChangeNotifier {
  List<JournalM> _journal = [];

  List<JournalM> get item => _journal;

  Future loadjournalItems(String numOpera) async {
    final String params="numopera=$numOpera";
    final url =Uri.parse(ApiConstants.baseUrl + ApiConstants.journalBrouillard+params);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _journal = List<JournalM>.from(
        data.map((json) => JournalM.fromjson(json)),
      );
      notifyListeners();
    } else {
      log('Une erreur produite: ${response.statusCode}');
      throw 'Une erreur produite';
    }
  }
}
