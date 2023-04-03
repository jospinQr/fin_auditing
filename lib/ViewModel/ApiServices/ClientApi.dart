import 'dart:convert';
import 'dart:developer';


import 'package:fin_auditing/ViewModel/ApiServices/ApiConstants.dart';
import 'package:fin_auditing/Functions/MyExpextion.dart';

import 'package:fin_auditing/Models/ClientM.dart';


import 'package:http/http.dart' as http;

class ClientApi {
  List<ClientM> parseClient(String responseBody) => List<ClientM>.from(
      jsonDecode(responseBody).map((x) => ClientM.fromjson(x)));

  Future<List<ClientM>?> getClient(String packageName) async{

      final url=Uri.parse(ApiConstants.baseUrl+ApiConstants.clientEndPoint);
      final response=await http.get(url);

      if(response.statusCode!=200){

          log(response.statusCode.toString());
          throw PackageRecupererException(packageName: packageName);
        
      }

      List<ClientM> _clients=parseClient(response.body);

      return _clients;
  }   
}
