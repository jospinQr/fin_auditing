import 'dart:convert';
import 'dart:developer';
import 'package:fin_auditing/Constants/ApiConstants.dart';
import 'package:fin_auditing/Functions/MyExpextion.dart';
import 'package:fin_auditing/Models/User.dart';
import 'package:http/http.dart' as http;

class UserApi {

  Future<User> getUser(String packageName) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndPoint);
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw PackageRecupererException(
          packageName: packageName, statusCode: response.statusCode);
    }
    return User.fromjson(json.decode(response.body)[0]);
  }
}
