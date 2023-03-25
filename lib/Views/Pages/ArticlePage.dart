import 'dart:convert';
import 'dart:async';

import 'package:fin_auditing/ModelView/ApiServices/ApiConstants.dart';
import 'package:fin_auditing/ModelView/ApiServices/ArticleApi.dart';
import 'package:fin_auditing/Models/ArticleM.dart';
import 'package:fin_auditing/Views/Drawer/myHeaderDrawer.dart';
import 'package:fin_auditing/Views/Pages/AddArticlePage.dart';
import 'package:fin_auditing/Views/Pages/LoginPage.dart';
import 'package:flutter/material.dart';

import 'DetailArticlePage.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late List<Article>? _articles = [];

  @override
  void initState() {
    super.initState();
    _getArticleData('http');
  }

  void _getArticleData(String packageName) async {
    _articles = (await ArticleApi().getArticles(packageName))!;
    Future.delayed(const Duration(milliseconds: 800))
        .then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
        title: const Text("Liste des articles"),
      ),
      body: _articles == null || _articles!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: _articles!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image(
                    width: 80,
                    height: 90,
                    image: NetworkImage(ApiConstants.severUrl +
                        ApiConstants.imageUrl +
                        _articles![index].photo.toString()),
                  ),
                  title: Text(_articles![index].designart),
                  subtitle: Text(
                    _articles![index].valsunit1.toString(),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detail(
                          _articles![index],
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
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddArticle(),
            ),
          );
        },
        child: const Icon(
          Icons.add_box_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
