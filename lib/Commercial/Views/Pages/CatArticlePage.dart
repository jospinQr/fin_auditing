import 'dart:convert';
import 'dart:developer';

import 'package:fin_auditing/Commercial/Models/CategorieM.dart';
import 'package:fin_auditing/Commercial/Views/Pages/ArticlePage.dart';
import 'package:flutter/material.dart';
import 'package:fin_auditing/Commercial/Constants/ApiConstants.dart'
    as comConst;
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../Public/Functions/MyExpextion.dart';
import '../../../Public/ViewModel/AgenceVM.dart';
import '../../../Public/Views/Pages/LoadingPage.dart';

class CatArticlePage extends StatefulWidget {
  const CatArticlePage({Key? key}) : super(key: key);

  @override
  State<CatArticlePage> createState() => _CatArticlePageState();
}

class _CatArticlePageState extends State<CatArticlePage> {
  List<CatArticleM> parseArticle(String responseBody) => List<CatArticleM>.from(
      jsonDecode(responseBody).map((x) => CatArticleM.fromjson(x)));

  Future<List<CatArticleM>?> fetchArticle(String packageName) async {
    final url = Uri.parse(
        "${publicConst.AipConstants.baseUrl}${comConst.ApiConstants.catArticleEndPoint}");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<CatArticleM> Categorie = parseArticle(response.body);

    return Categorie;
  }

  @override
  Widget build(BuildContext context) {
    var agence = Provider.of<AgenceVM>(context);
    return FutureBuilder(
        future: fetchArticle("http"),
        builder: (context, AsyncSnapshot<List<CatArticleM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              title: const Text("Liste des catégorie d'article"),
            ),
            body: ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 0, 129, 129),
                    child: Text(snapshot.data![index].numCateg[0]),
                  ),
                  title: Text(snapshot.data![index].numCateg),
                  subtitle: Text(
                    snapshot.data![index].designCateg,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(
                          numCateg: snapshot.data![index].numCateg,
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 0.1,
                  color: Color.fromARGB(255, 0, 129, 129),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              onPressed: () {},
              child: const Icon(
                Icons.add_box_rounded,
                color: Colors.white,
              ),
            ),
          );
        });
  }
}
