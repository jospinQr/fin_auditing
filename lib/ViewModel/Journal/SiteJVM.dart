import 'dart:convert';
import 'package:fin_auditing/Models/Site.dart';
import 'package:flutter/foundation.dart';
import '../../Models/AgenceM.dart';
import '../../Models/Journal/SiteJM.dart';
import '../ApiServices/ApiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SiteJVM with ChangeNotifier {
  List<SiteJM> _site = [];

  List<SiteJM> get items => _site;

  Future loadSiteItems(String codAge) async {
    final String param = "codag=$codAge";
    final url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.Journalgroupsite + param);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _site = List<SiteJM>.from(
        data.map((json) => SiteJM.fromjson(json)),
      );
      notifyListeners();
    } else {
      throw 'Une erreur produite';
    }
  }
}
