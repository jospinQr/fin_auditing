import 'dart:convert';
import 'package:fin_auditing/Models/Site.dart';
import 'package:flutter/foundation.dart';
import '../../Models/AgenceM.dart';
import '../../Models/Journal/SiteJM.dart';
import '../../Constants/ApiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SiteJVM with ChangeNotifier {
  List<SiteJM> _listSite = [];

  late String _codeSite;



  //get and set listOf liste
  List<SiteJM> get items => _listSite;
  void setListSite(List<SiteJM> listSite){
     _listSite=listSite;
  }


  //get and set codeSite
  String get getcodeSite=>_codeSite;
  void setCodeSite(String codeSite){
      _codeSite=codeSite;
  }

  Future loadSiteItems(String CodAnne,String CodAge) async {
    final String param = "codan=$CodAnne&&codag=$CodAge";
    final url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.Journalgroupsite+param);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _listSite = List<SiteJM>.from(
        data.map((json) => SiteJM.fromjson(json)),
      );
      notifyListeners();
    } else {
      throw 'Une erreur produite ${response.statusCode}';
    }
  }
}
