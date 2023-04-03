import 'package:fin_auditing/ViewModel/ApiServices/ApiConstants.dart';
import 'package:flutter/material.dart';

import '../../Models/ArticleM.dart';

class Detail extends StatelessWidget {
  final Article article;
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
    padding:EdgeInsets.all(40),
    child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: NetworkImage(ApiConstants.severUrl+ApiConstants.imageUrl+
                    article.photo),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 0, 129, 129),
              height: 34,
              thickness: 02,
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
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Prix :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("${article.valsunit1}\$")
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Text(
                  "Categorie :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text("${article.numcatart}\$")
              ],
            ),
            const SizedBox(
              height: 20,
            ),
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
