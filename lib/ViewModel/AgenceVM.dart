import 'dart:convert';
import 'package:fin_auditing/Constants/ApiConstants.dart';
import 'package:fin_auditing/Models/AgenceM.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/Site.dart';


class AgenceVM with ChangeNotifier {
  List<Agence> _agence = [];
  List<Site> _site=[];


  List<Agence> get items => _agence;
  List <Site> get itemsSite=>_site;



  Future loadAgenceItems() async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.agenceEndPoint);
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


  Future loadSiteItems() async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.siteEndPoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _site = List<Site>.from(
        data.map((json) => Site.fromjson(json)),
      );
      notifyListeners();
    } else {
      throw 'Une erreur produite';
    }
  }


 


}
