
import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../Functions/MyExpextion.dart';
import '../../Models/Site.dart';
import 'ApiConstants.dart';


class SiteApi{

  List<Site> parseSite(String responseBody) => List<Site>.from(
      jsonDecode(responseBody).map((x) => Site.fromjson(x)));

  Future<List<Site>> getSite(String packageName) async{

    final url=Uri.parse(ApiConstants.baseUrl+ApiConstants.clientEndPoint);
    final response=await http.get(url);

    if(response.statusCode!=200){
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<Site> _site=parseSite(response.body);

    return _site;
  }



}