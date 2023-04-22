import 'dart:convert';
import 'dart:developer';



import 'package:http/http.dart' as http;
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import '../../Commercial/Models/ArticleM.dart';
import '../../../Public/Functions/MyExpextion.dart';
import '../../Comptablite/Constants/ApiConstants.dart';



class ArticleApi {
  List<ArticleM> parseArticle(String responseBody) => List<ArticleM>.from(
      json.decode(responseBody).map((x) => ArticleM.fromjson(x)));

// get articles
  Future<List<ArticleM>?> getArticles(String packageName) async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl );
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(
          packageName: packageName, statusCode: response.statusCode);
    }
    List<ArticleM> articles = parseArticle(response.body);
    return articles;
  }

  Future<void> postArticle(String packageName) async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl );
    // final response = await http.post(url,body: );
  }

  Future<String> _getArticleCount(String packageName) async {
    final url =
        Uri.parse( publicConst.AipConstants.baseUrl);
    final response = await http.get(url);
    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(
          packageName: packageName, statusCode: response.statusCode);
    }
    
    return response.body.toString();

  }
}
