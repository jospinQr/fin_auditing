import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Public/ViewModel/ExerciceVM.dart';

import 'package:fin_auditing/Comptablite/ViewModel/TypeRapportVM.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Models/AgenceM.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';

import '../../../Models/Journal/DebitCredit.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import '../../../ViewModel/Journal/AgenceJVM.dart';
import 'ListeSitePage.dart';


class ListAgencePage extends StatefulWidget {
  const ListAgencePage({Key? key}) : super(key: key);

  @override
  State<ListAgencePage> createState() => _ListAgencePageState();
}

class _ListAgencePageState extends State<ListAgencePage> {
  List<Agence> parseAgence(String responseBody) =>
      List<Agence>.from(jsonDecode(responseBody).map((x) => Agence.fromjson(x)))
          .toList();

  Future<List<Agence>?> fetchSite(
      String packageName, String urlEndPoint) async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl + urlEndPoint);
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
    AgenceJVM _agence = Provider.of<AgenceJVM>(context);
    TypeRapportVM _rapport = Provider.of<TypeRapportVM>(context);
    ExerciceVM _exercice = Provider.of<ExerciceVM>(context);

    return FutureBuilder<List<Agence>?>(
        future: _rapport.getRapportName == "Journal Brouillard" ||
                _rapport.getRapportName == "Journal Chronologique"
            ? fetchSite("http", "${ApiConstants.Journalgroupagence}codan=${_exercice.getAnnee}&&obsopera=${_rapport.getObservation}")
            : fetchSite("http",
                "${ApiConstants.journalgroupagencetypeora}typeopera=${_rapport.getTypeJournal}&&codan=${_exercice.getAnnee}"),
        builder: (context, AsyncSnapshot<List<Agence>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Choisissez un agence"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
            ),
            body:snapshot.data!.isNotEmpty? ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].codAge.toString()),
                  subtitle: Text(snapshot.data![index].desinAge.toString()),
                  onTap: () {
                    _agence.setCodAge(snapshot.data![index].codAge.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListSitePage(
                          agence: _agence.getCodeAgence,
                        ),
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
            ):const Center(child: Text("Aucune agence n'a effectuer ce type d'operation"),),
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
        });
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  List<DebitCredit> parseClient(String responseBody) => List<DebitCredit>.from(
      jsonDecode(responseBody).map((x) => DebitCredit.fromjson(x)));

  Future<List<DebitCredit>?> getDebitCredit(
      String packageName, String param) async {
    final url = Uri.parse(
        publicConst.AipConstants.baseUrl + ApiConstants.journalTotalAgence + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<DebitCredit> debitCredit = parseClient(response.body);

    return debitCredit;
  }

  Future<List<DebitCredit>?> getDebitCreditType(
      String packageName, String param) async {
    final url = Uri.parse(
        publicConst.AipConstants.baseUrl + ApiConstants.journalTotalAgenceType + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<DebitCredit> debutCredit = parseClient(response.body);

    return debutCredit;
  }

  @override
  Widget build(BuildContext context) {
    var annee = Provider.of<ExerciceVM>(context);
    var observation = Provider.of<TypeRapportVM>(context);
    var rapport = Provider.of<TypeRapportVM>(context);

    return FutureBuilder(
        future: rapport.getRapportName == "Journal Brouillard" ||
                rapport.getRapportName == "Journal Chronologique"
            ? getDebitCredit("http",
                "codan=${annee.getAnnee}&&obsopera=${observation.getObservation}")
            : getDebitCreditType("http",
                "codan=${annee.getAnnee}&&typeopera=${rapport.getTypeJournal}"),
        builder: (index, snap) {
          if (!snap.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
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
                  )
                ],
              ));
        });
  }
}
