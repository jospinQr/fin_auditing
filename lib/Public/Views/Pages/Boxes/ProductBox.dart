import 'package:fin_auditing/Commercial/Models/ArticleM.dart';
import 'package:flutter/material.dart';

class ProductBox extends StatelessWidget {
  ProductBox({required Key key, required this.item}) : super(key: key);
  final ArticleM item;

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/appimages/${item.photo}"),
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(item.designart,
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(item.numart.toString()),
                            Text("Price: ${item.valsunit1}"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.star,
                                    size: 20,
                                    color: Color.fromARGB(255, 0, 129, 129)),
                                Icon(Icons.star,
                                    size: 20,
                                    color: Color.fromARGB(255, 0, 129, 129)),
                                Icon(Icons.star_border,
                                    size: 20,
                                    color: Color.fromARGB(255, 0, 129, 129)),
                                Icon(Icons.star_border,
                                    size: 20,
                                    color: Color.fromARGB(255, 0, 129, 129)),
                                Icon(Icons.star_border,
                                    size: 20,
                                    color: Color.fromARGB(255, 0, 129, 129))
                              ],
                            ),
                          ],
                        )))
              ]),
        ));
  }
}
