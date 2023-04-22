import 'dart:convert';
import 'dart:developer';

import 'package:fin_auditing/Commercial/Models/ClientM.dart';
import 'package:fin_auditing/Commercial/Models/FournisseurM.dart';
import 'package:fin_auditing/Commercial/Views/Pages/DetailFournisseur.dart';

import 'package:flutter/material.dart';

import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:fin_auditing/Commercial/Constants/ApiConstants.dart' as comConst;
import '../../../Public/ApiServices/ClientApi.dart';
import '../../../Public/Functions/MyExpextion.dart';
import '../../../Public/Views/Pages/LoadingPage.dart';
import 'DetailClientPage.dart';
import 'package:http/http.dart' as http;

class FournisseurPage extends StatefulWidget {
  const FournisseurPage({super.key});

  @override
  State<FournisseurPage> createState() => _FournisseurPageState();
}

class _FournisseurPageState extends State<FournisseurPage> {
  List<FournisseurM> parse(String responseBody) => List<FournisseurM>.from(
      jsonDecode(responseBody).map((x) => FournisseurM.fromjson(x)));

  Future<List<FournisseurM>?> fetchFournisseur(String packageName) async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl+comConst.ApiConstants.fournisseurEndPoint);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<FournisseurM> debitCredit = parse(response.body);

    return debitCredit;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchFournisseur("http"),
        builder: (context, AsyncSnapshot<List<FournisseurM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              title: const Text("List des fournisseurs"),
              actions: <Widget>[

              ],
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 0, 129, 129),
                    child: Text(snapshot.data![index].nomFourni[0]),
                  ),
                  title: Text(snapshot.data![index].nomFourni),
                  subtitle: Text(snapshot.data![index].nomFourni),
                  trailing:Text(snapshot.data![index].villeFourni) ,
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailFounisseurPage(fournisseur: snapshot.data![index],
                          
                        ),
                      ),
                    )
                  },
                );
              },

            ),
          );
        });
  }
}
