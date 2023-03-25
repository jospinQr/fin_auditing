import 'dart:convert';

import 'package:fin_auditing/Models/Journal/SiteJM.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../ViewModel/ApiServices/ApiConstants.dart';

class Essai extends StatefulWidget {
  const Essai({Key? key}) : super(key: key);

  @override
  State<Essai> createState() => _EssaiState();
}


class _EssaiState extends State<Essai> {


  List<SiteJM>? _site = [];

  List<SiteJM> parseArticle(String responseBody) =>
      List<SiteJM>.from(json.decode(responseBody).map((x) => SiteJM.fromjson(x)));

  Future getSite() async {
    const String param = "codag=A01";
    final url =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.Journalgroupsite + param);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      _site = parseArticle(response.body);
      return _site;
    } else {
      throw 'Une erreur produite';
    }
  }

  @override
  void initState() {

    super.initState();
    getSite();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _site!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_site![index].designsite),
                      subtitle: Text(_site![index].codsite),
                    );
                  },
                  itemCount: _site!.length,
                )
              ],
            ),
    );
  }
}
