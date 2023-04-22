import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Comptablite/Models/GrandLivre/SoldeM.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Models/AgenceM.dart';
import '../../../../Public/ViewModel/AgenceVM.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';

import '../../../ViewModel/Gand Livre/CompteVM.dart';
import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../../ViewModel/TypeRapportVM.dart';
import 'Site.dart';


class ListAgencePageGrdl extends StatefulWidget {
  const ListAgencePageGrdl({Key? key}) : super(key: key);

  @override
  State<ListAgencePageGrdl> createState() => _ListAgencePageGrdlState();
}

class _ListAgencePageGrdlState extends State<ListAgencePageGrdl> {
  List<Agence> parseAgence(String responseBody) =>
      List<Agence>.from(jsonDecode(responseBody).map((x) => Agence.fromjson(x)))
          .toList();

  Future<List<Agence>?> getGLAgence(
      String packageName, String urlEndPoint, String params) async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl + urlEndPoint + params);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<Agence>? agence = parseAgence(response.body);
    return agence;
  }

  @override
  Widget build(BuildContext context) {
    var typeRapport = Provider.of<TypeRapportVM>(context);
    var annee = Provider.of<ExerciceVM>(context);
    var compte = Provider.of<CompteVM>(context);
    var agence = Provider.of<AgenceVM>(context);

    dynamic fetchByType() {
      if (typeRapport.getRapportName == "Patrimoine" ||
          typeRapport.getRapportName == "Exploitation") {
        return getGLAgence("http", ApiConstants.grandLivreAgence,
            "codan=${annee.getAnnee}&&numcpte=${compte.getNumCompte}");
      } else if (typeRapport.getRapportName == "ACTIF" ||
          typeRapport.getRapportName == "PASSIF" ||
          typeRapport.getRapportName == "CHARGE" ||
          typeRapport.getRapportName == "PRODUIT") {
        return getGLAgence("http", ApiConstants.grandLivreAgenceType,
            "codan=${annee.getAnnee}&&numcpte=${compte.getNumCompte}&&naturecpte=${typeRapport.getRapportName}");
      }
    }

    return FutureBuilder<List<Agence>?>(
      future: fetchByType(),
      builder: (context, AsyncSnapshot<List<Agence>?> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingPage();
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              compte.getNumCompte + compte.getInitCompte,
              style: const TextStyle(fontSize: 13),
            ),
            backgroundColor: const Color.fromARGB(255, 0, 129, 129),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].codAge),
                subtitle: Text(snapshot.data![index].desinAge),
                onTap: () {
                  agence.setCodAg(snapshot.data![index].codAge);
                  agence.setDesign(snapshot.data![index].desinAge);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListSitePageGrdL(),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 1,
                color: Color.fromARGB(255, 0, 129, 129),
              );
            },
            itemCount: snapshot.data?.length ?? 0,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(

                context: context,
                builder: (context) => const BottomSheet(),

              );
            },
            backgroundColor: const Color.fromARGB(255, 0, 129, 129),
            child: Spin(
              child: const Icon(
                Icons.stacked_line_chart,
                color: Colors.white70,
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  List<SoldeM> parseSole(String responseBody) => List<SoldeM>.from(
      jsonDecode(responseBody).map((x) => SoldeM.fromjson(x)));

  Future<List<SoldeM>?> fetchSolde(String packageName, String param) async {
    final url = Uri.parse(
        publicConst.AipConstants.baseUrl+ ApiConstants.grandLivreCompteSolde + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<SoldeM> _clients = parseSole(response.body);

    return _clients;
  }

  @override
  Widget build(BuildContext context) {
    var annee = Provider.of<ExerciceVM>(context);
    var compte = Provider.of<CompteVM>(context);
    return FutureBuilder(
        future: fetchSolde(
            "http", "codan=${annee.getAnnee}&&numcpte=${compte.getNumCompte}"),
        builder: (index, snap) {
          if (!snap.hasData) {
            return const Center(
              child: LoadingPage(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Total compte ${compte.getInitCompte}",style: TextStyle(fontSize:11),),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
            ),
            body: Container(
              height: 150,
              padding: EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 129, 129),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Débit",
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold)),
                      Text("Crédit",
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BounceInLeft(
                        child: Text(
                          snap.data![0].debit,
                          style: const TextStyle(color: Colors.white60),
                        ),
                      ),
                      BounceInRight(
                        child: Text(
                          snap.data![0].credit,
                          style: const TextStyle(color: Colors.white60),
                        ),
                      ),
                    ],
                  ),
                  BounceInUp(
                    child: Center(
                      child: Text("Solde : ${snap.data![0].solde} ", style:const TextStyle(
                          color: Colors.white60,
                          fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
