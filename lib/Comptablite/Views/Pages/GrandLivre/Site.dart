import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:fin_auditing/Public/Models/Site.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/ViewModel/AgenceVM.dart';
import '../../../../Public/ViewModel/SiteVM.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Models/GrandLivre/SoldeM.dart';
import '../../../ViewModel/Gand Livre/CompteVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../../ViewModel/TypeRapportVM.dart';
import 'GrandLivre.dart';

class ListSitePageGrdL extends StatefulWidget {
  const ListSitePageGrdL({Key? key}) : super(key: key);

  @override
  State<ListSitePageGrdL> createState() => _ListSitePageGrdLState();
}

class _ListSitePageGrdLState extends State<ListSitePageGrdL> {
  List<Site> parseSite(String responseBody) =>
      List<Site>.from(jsonDecode(responseBody).map((x) => Site.fromjson(x)))
          .toList();

  Future<List<Site>?> getGLSite(
      String packageName, String urlEndPoint, String params) async {
    final url =
        Uri.parse(publicConst.AipConstants.baseUrl + urlEndPoint + params);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<Site>? site = parseSite(response.body);
    return site;
  }

  @override
  Widget build(BuildContext context) {
    var typeRapport = Provider.of<TypeRapportVM>(context);
    var annee = Provider.of<ExerciceVM>(context);
    var compte = Provider.of<CompteVM>(context);
    var agence = Provider.of<AgenceVM>(context);
    var site = Provider.of<SiteVM>(context);

    dynamic fetchByType() {
      if (typeRapport.getRapportName == "Patrimoine" ||
          typeRapport.getRapportName == "Exploitation") {
        return getGLSite("http", ApiConstants.grandLivreSite,
            "codan=${annee.getAnnee}&&numcpte=${compte.getNumCompte}&&codag=${agence.getCodAg}");
      } else if (typeRapport.getRapportName == "ACTIF" ||
          typeRapport.getRapportName == "PASSIF" ||
          typeRapport.getRapportName == "CHARGE" ||
          typeRapport.getRapportName == "PRODUIT") {
        return getGLSite("http", ApiConstants.grandLivreSiteType,
            "codan=${annee.getAnnee}&&numcpte=${compte.getNumCompte}&&codag=${agence.getCodAg}&&naturecpte=${typeRapport.getRapportName}");
      }
    }

    return FutureBuilder<List<Site>?>(
      future: fetchByType(),
      builder: (context, AsyncSnapshot<List<Site>?> snapshot) {
        if (!snapshot.hasData) {
          return const LoadingPage();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text("Choisissez un agence"),
            backgroundColor: const Color.fromARGB(255, 0, 129, 129),
          ),
          body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].codsite),
                subtitle: Text(snapshot.data![index].designsite),
                onTap: () {
                  site.setCodeSite(snapshot.data![index].codsite);
                  site.setDesignSite(snapshot.data![index].designsite);
                  //Fonctions.MessageDialog("",site.getCodeSite+compte.getInitCompte+agence.getCodAg+annee.getAnnee , context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GrandLivrePage()),
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
    final url = Uri.parse(publicConst.AipConstants.baseUrl +
        ApiConstants.grandLivreAgenceSolde +
        param);
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
    var agence = Provider.of<AgenceVM>(context);
    return FutureBuilder(
        future: fetchSolde("http",
            "codan=${annee.getAnnee}&&numcpte=${compte.getNumCompte}&&codag=${agence.getCodAg}"),
        builder: (index, snap) {
          if (!snap.hasData) {
            return const Center(
              child: LoadingPage(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Total Agence de  ${agence.getDesign}",
                style: TextStyle(fontSize: 15),
              ),
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
                      child: Text("Solde : ${snap.data![0].solde} ",
                          style: const TextStyle(
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
