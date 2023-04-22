import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:fin_auditing/Commercial/Models/ArticleM.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fin_auditing/Commercial/Constants/ApiConstants.dart'
    as comConst;
import '../../../Public/Functions/MyExpextion.dart';
import '../../../Public/Views/Pages/LoadingPage.dart';
import 'DetailArticlePage.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key, required this.numCateg})
      : super(key: key);
  final String numCateg;


  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<ArticleM> parseArticle(String responseBody) => List<ArticleM>.from(
      jsonDecode(responseBody).map((x) => ArticleM.fromjson(x)));

  Future<List<ArticleM>?> fetchArticle(String packageName) async {
    final url = Uri.parse(
        "${publicConst.AipConstants.baseUrl}${comConst.ApiConstants.articleUrlEndPoint}numcatart=${widget.numCateg}");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<ArticleM> article = parseArticle(response.body);

    return article;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchArticle("http"),
        builder: (context, AsyncSnapshot<List<ArticleM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              title: const Text("Liste des articles"),
            ),
            body: ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image(
                    width: 80,
                    height: 90,
                    image: NetworkImage(publicConst.AipConstants.severUrl +
                        publicConst.AipConstants.imageUrl +
                        snapshot.data![index].photo),
                  ),
                  title: Text(snapshot.data![index].designart),
                  subtitle: Text(snapshot.data![index].numart),
                  trailing: Text(snapshot.data![index].numcatart),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          snapshot.data![index],
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
