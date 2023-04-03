import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/ViewModel/Journal/JournalVM.dart';
import 'package:fin_auditing/ViewModel/Journal/OperationJVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../ComptabilitePage.dart';

class JournalPage extends StatefulWidget {
  JournalPage({Key? key, required this.numOperation}) : super(key: key);
  String numOperation;

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    var journal = Provider.of<JournalVM>(context);
    var operation = Provider.of<OperationJVM>(context);

    return FutureBuilder(
        future: journal.loadjournalItems(widget.numOperation),
        builder: (context, snapshot) {
      if (journal.item.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Chargement en cours..."),
            backgroundColor: const Color.fromARGB(255, 0, 129, 129),
          ),
          body: const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.cyanAccent,
            ),
          ),
        );
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
                  Text(journal.item[0].codan),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(journal.item[0].descan)
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
                  Text(journal.item[0].designag),
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
                  Text(journal.item[0].designsite)
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
                  Text(journal.item[0].numopera)
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
                  Text(journal.item[0].libopera)
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
                  Text(journal.item[0].nomut)
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
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      DataTable(
                        sortAscending: true,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 0, 129, 129)),
                        columns: const [
                          DataColumn(
                              label: Text("No compte",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("Intitulé Compte",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("Nature",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("Débit",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("Crédit",
                                  style: TextStyle(color: Colors.white70)))
                        ],
                        rows: journal.item!
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(e.numcpte)),
                                  DataCell(Text(e.intitulecpte)),
                                  DataCell(Text(e.naturecpte)),
                                  DataCell(Text(e.mntd)),
                                  DataCell(Text(e.mntcr)),
                                ]))
                            .toList(),
                      )
                    ],
                  ),
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
                      "Crédit : ${operation.getOperation.mntd}",
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
