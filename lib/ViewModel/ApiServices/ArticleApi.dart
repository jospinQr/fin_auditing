import 'dart:convert';
import 'dart:developer';

import 'package:fin_auditing/ViewModel/ApiServices/ApiConstants.dart';
import 'package:fin_auditing/Functions/MyExpextion.dart';
import 'package:http/http.dart' as http;

import '../../Models/ArticleM.dart';
import '../../Models/User.dart';

class ArticleApi {
  List<Article> parseArticle(String responseBody) => List<Article>.from(
      json.decode(responseBody).map((x) => Article.fromjson(x)));

// get articles
  Future<List<Article>?> getArticles(String packageName) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.articleEndPoint);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(
          packageName: packageName, statusCode: response.statusCode);
    }
    List<Article> _articles = parseArticle(response.body);
    return _articles;
  }

  Future<void> postArticle(String packageName) async {
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.articleEndPoint);
    // final response = await http.post(url,body: );
  }

  Future<String> _getArticleCount(String packageName) async {
    final url =
        Uri.parse(ApiConstants.baseUrl + ApiConstants.articleCountEndPoint);
    final response = await http.get(url);
    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(
          packageName: packageName, statusCode: response.statusCode);
    }
    
    return response.body.toString();

  }
}
