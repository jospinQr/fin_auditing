import 'dart:convert';
import 'dart:developer';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:fin_auditing/Commercial/Models/ClientM.dart';
import 'package:http/http.dart' as http;
import '../Functions/MyExpextion.dart';

class ClientApi {
  List<ClientM> parseClient(String responseBody) => List<ClientM>.from(
      jsonDecode(responseBody).map((x) => ClientM.fromjson(x)));

  Future<List<ClientM>?> getClient(String packageName) async{

      final url=Uri.parse(publicConst.AipConstants.baseUrl);
      final response=await http.get(url);

      if(response.statusCode!=200){

          log(response.statusCode.toString());
          throw PackageRecupererException(packageName: packageName);
        
      }

      List<ClientM> _clients=parseClient(response.body);

      return _clients;
  }   
}
