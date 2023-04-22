import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../../Models/JounarlM.dart';
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';

import '../../../ViewModel/Journal/OperationJVM.dart';
import '../../../ViewModel/TypeRapportVM.dart';
import '../../ComptabilitePage.dart';


class JournalPage extends StatefulWidget {
  JournalPage({Key? key, required this.numOperation}) : super(key: key);
  String numOperation;

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  List<JournalM> parseJournal(String responseBody) => List<JournalM>.from(
      jsonDecode(responseBody).map((x) => JournalM.fromjson(x)));

  Future<List<JournalM>?> getJournal(
      String packageName, String numOpera) async {
    final String params = "numopera=$numOpera";
    final url = Uri.parse(publicConst.AipConstants.baseUrl + ApiConstants.journal + params);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<JournalM>? journal = parseJournal(response.body);
    return journal;
  }

  @override
  void initState() {
    super.initState();
    getJournal("http", widget.numOperation);
  }

  @override
  Widget build(BuildContext context) {
    var operation = Provider.of<OperationJVM>(context);
    return FutureBuilder(
        future: getJournal("http", widget.numOperation),
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
                      Text(snapshot.data![0].codan),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(snapshot.data![0].descan)
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
                      Text(snapshot.data![0].designag),
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
                      Text(snapshot.data![0].designsite)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "No Operation",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 129, 129),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(snapshot.data![0].numopera)
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
                      Text(snapshot.data![0].libopera)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(
                        "Par :",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 129, 129),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(snapshot.data![0].nomut)
                    ],
                  ),
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
                      child: SingleChildScrollView(scrollDirection:Axis.horizontal,child: Column(
                        children: [
                           DataTable(
                              sortAscending: true,
                              headingRowColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      const Color.fromARGB(255, 0, 129, 129)),
                              columns: const [
                                DataColumn(
                                    label: Text("No compte",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Intitulé Compte",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Nature",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Débit",
                                        style:
                                            TextStyle(color: Colors.white70))),
                                DataColumn(
                                    label: Text("Crédit",
                                        style:
                                            TextStyle(color: Colors.white70)))
                              ],
                              rows: snapshot.data!
                                  .map((e) => DataRow(cells: [
                                        DataCell(Text(e.numcpte)),
                                        DataCell(Text(e.intitulecpte)),
                                        DataCell(Text(e.naturecpte)),
                                        DataCell(Text(e.mntd)),
                                        DataCell(Text(e.mntcr)),
                                      ]))
                                  .toList(),

                          ),
                        ],
                      ),),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 129, 129),
                        borderRadius: BorderRadius.circular(34)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Début : ${operation.getOperation.mntd}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          "Crédit : ${operation.getOperation.mntcr}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
