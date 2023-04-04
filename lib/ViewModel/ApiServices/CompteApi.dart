import 'dart:convert';
import 'dart:developer';

import 'package:fin_auditing/Constants/ApiConstants.dart';
import 'package:fin_auditing/Functions/MyExpextion.dart';
import 'package:fin_auditing/Models/CompteM.dart';
import 'package:http/http.dart' as http;

class CompteApi {
  List<Compte> parseCompte(String responseBody) => List<Compte>.from(
      json.decode(responseBody).map((x) => Compte.fromjson(x)));
// get compte
  Future<List<Compte>?> getComptes(String packageName) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.compteEndPoint);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(
          packageName: packageName, statusCode: response.statusCode);
    }
    List<Compte> _comptes = parseCompte(response.body);
    return _comptes;
  }
}
