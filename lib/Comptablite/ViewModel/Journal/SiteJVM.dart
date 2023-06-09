import 'dart:convert';
import 'dart:developer';
import 'package:fin_auditing/Public/Models/Site.dart';
import 'package:flutter/foundation.dart';
import '../../../Public/Constants/ApiConatants.dart' as publicApi;
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

  Future loadSiteItems(String CodAnne,String CodAge,String observation) async {
    final String param = "codan=$CodAnne&&codag=$CodAge&&obsopera=$observation";
    final url =
        Uri.parse(publicApi.AipConstants.baseUrl + ApiConstants.Journalgroupsite+param);
    final response = await http.get(url);


    if (response.statusCode == 200) {

      final data = json.decode(response.body);
      _listSite = List<SiteJM>.from(
        data.map((json) => SiteJM.fromjson(json)),
      );
      notifyListeners();
    }

    else {
      throw 'Une erreur produite ${response.statusCode}';
    }
  }


  Future loadSiteTypeItems(String CodAnne,String CodAge,String urlEndPoint) async {
    final String param = "codan=$CodAnne&&codag=$CodAge&&typeopera=$urlEndPoint";
    final url =
    Uri.parse(publicApi.AipConstants.baseUrl+ ApiConstants.journalgroupsiteType+param);
    final response = await http.get(url);


    if (response.statusCode == 200) {

      final data = json.decode(response.body);
      _listSite = List<SiteJM>.from(
        data.map((json) => SiteJM.fromjson(json)),
      );
      notifyListeners();
    }

    else {
      throw 'Une erreur produite ${response.statusCode}';
    }
  }
}
