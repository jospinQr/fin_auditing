import 'dart:convert';

import 'package:fin_auditing/Public/Models/AgenceM.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/Site.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;



class AgenceVM with ChangeNotifier {

  late String _codAgence;
  late String _designAgence;
  List<Agence> _agence = [];
  List<Site> _site=[];


  List<Agence> get items => _agence;
  List <Site> get itemsSite=>_site;

  String get getCodAg=>_codAgence;
  String get getDesign=>_designAgence;

  void setCodAg(String codAge){
     _codAgence=codAge;
  }

  void setDesign(String designAge){
    _designAgence=designAge;
  }

  Future loadAgenceItems() async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl + publicConst.AipConstants.agenceEndPoint);
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
    final url = Uri.parse(publicConst.AipConstants.baseUrl + publicConst.AipConstants.siteEndPoint);
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
