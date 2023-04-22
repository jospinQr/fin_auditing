import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/ViewModel/AgenceVM.dart';
import '../../../../Public/ViewModel/SiteVM.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';

import '../../../Models/GrandLivre/OperationM.dart';

import 'package:http/http.dart' as http;
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;

import '../../../ViewModel/Gand Livre/CompteVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../ComptabilitePage.dart';


class GrandLivrePage extends StatefulWidget {
  const GrandLivrePage({Key? key}) : super(key: key);

  @override
  State<GrandLivrePage> createState() => _GrandLivrePageState();
}

class _GrandLivrePageState extends State<GrandLivrePage> {
  List<GrandLivreM> parseGrandLivre(String responseBody) =>
      List<GrandLivreM>.from(
          jsonDecode(responseBody).map((x) => GrandLivreM.fromjson(x)));

  Future<List<GrandLivreM>?> fetchGrandLivre(
      String packageName, String params) async {
    final url = Uri.parse(
        publicConst.AipConstants.baseUrl+ ApiConstants.grandLivreOperation + params);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<GrandLivreM>? journal = parseGrandLivre(response.body);
    return journal;
  }

  @override
  Widget build(BuildContext context) {
    var exercice = Provider.of<ExerciceVM>(context);
    var compte = Provider.of<CompteVM>(context);
    var agence = Provider.of<AgenceVM>(context);
    var site = Provider.of<SiteVM>(context);
    return FutureBuilder<List<GrandLivreM>?>(
        future: fetchGrandLivre(
          "http",
          "codan=${exercice.getAnnee}&&numcpte=${compte.getNumCompte}"
              "&&codag=${agence.getCodAg}&&codsite=${site.getCodeSite}",
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 0, 129, 129),
                title: const Text("Visualisation du journal"),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComptabilitePage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.holiday_village_rounded)),
                ]),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Exercice :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 129, 129),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(exercice.getAnnee),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Agence :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 129, 129),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(agence.getDesign),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "=> :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 129, 129),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(site.getDesignSite)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "No du compte",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 129, 129),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(compte.getNumCompte)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Libelé :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 129, 129),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(compte.getInitCompte)
                    ],
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      "------- Détail -------",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 129, 129),
                      ),
                    ),
                  ),
                  BounceInDown(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            DataTable(
                              sortAscending: true,
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 0, 129, 129)),
                              columns: const [
                                DataColumn(
                                    label: Text("Date",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("No Opération",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Pieèce",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Libellé",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Début",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Crédit",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Solde",
                                        style:
                                            TextStyle(color: Colors.white70))),
                              ],
                              rows: snapshot.data!
                                  .map((e) => DataRow(cells: [
                                        DataCell(Text(e.dateOpera)),
                                        DataCell(Text(e.numOpera)),
                                        DataCell(Text(e.libeleOpera)),
                                        DataCell(Text(e.pieceOpera)),
                                        DataCell(Text(e.mntd)),
                                        DataCell(Text(e.mntcr)),
                                        DataCell(Text(e.sold)),
                                      ]))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
