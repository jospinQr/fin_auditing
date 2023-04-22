import 'package:flutter/material.dart';

import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;

import '../../Models/ArticleM.dart';

class Detail extends StatelessWidget {
  final ArticleM article;

  const Detail(this.article, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.designart),
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image(
                  image: NetworkImage(publicConst.AipConstants.severUrl +
                      publicConst.AipConstants.imageUrl +
                      article.photo),
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 0, 129, 129),
                height: 0,
                thickness: 02,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    "Numéro :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${article.numart}")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Designation :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(article.designart)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "TVA:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("${article.obstva}")
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Unité Principale :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(article.unitppal),
                  Text(article.valunitppal),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Sous unité 1 :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(article.sunit1),
                  Text(article.valsunit1),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Sous unité 2 :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(article.sunit2),
                  Text(article.valsunit2),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Sous unité 3 :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(article.sunit3),
                  Text(article.valsunit3),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Color.fromARGB(255, 0, 129, 129),
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Color.fromARGB(255, 0, 129, 129),
                  ),
                  Icon(
                    Icons.star_border,
                    size: 20,
                    color: Color.fromARGB(255, 0, 129, 129),
                  ),
                  Icon(
                    Icons.star_border,
                    size: 20,
                    color: Color.fromARGB(255, 0, 129, 129),
                  ),
                  Icon(
                    Icons.star_border,
                    size: 20,
                    color: Color.fromARGB(255, 0, 129, 129),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
