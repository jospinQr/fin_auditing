import 'package:fin_auditing/ModelView/JournalVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ModelView/AgenceVM.dart';
import '../../ModelView/ApiServices/ArticleApi.dart';
import '../../Models/ArticleM.dart';

class RapportPage extends StatefulWidget {
  const RapportPage({Key? key}) : super(key: key);

  @override
  State<RapportPage> createState() => _RapportPageState();
}

class _RapportPageState extends State<RapportPage> {
  late JournalVM journal;

  @override
  Widget build(BuildContext context) {
    journal = Provider.of<JournalVM>(context);
    if (journal.item.isEmpty) {
      journal.loadjournalItems();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyanAccent,
          ),
        ),
      );
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 129, 129),
          title: const Text("Visualisation du journal"),
        ),
        body: SingleChildScrollView(
          padding:const EdgeInsets.symmetric(horizontal:20),
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(height: 20),
                DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => const Color.fromARGB(255, 0, 129, 129)),
                  columns: const [
                    DataColumn(label: Text("Année")),
                    DataColumn(label: Text("Descrption année")),
                    DataColumn(label: Text("Numero opration")),
                    DataColumn(label: Text("Date operation")),
                    DataColumn(label: Text("Libelé")),
                    DataColumn(label: Text("Typeoperation")),
                    DataColumn(label: Text("Agence")),
                    DataColumn(label: Text("Site")),
                    DataColumn(label: Text("Montant credit")),
                    DataColumn(label: Text("Montant debit")),
                  ],
                  rows: journal.item!
                      .map((e) => DataRow(cells: [
                            DataCell(Text(e.codan)),
                            DataCell(Text(e.descan)),
                            DataCell(Text(e.numopera)),
                            DataCell(Text(e.dateopera)),
                            DataCell(Text(e.libopera)),
                            DataCell(Text(e.typeopera)),
                            DataCell(Text(e.designag)),
                            DataCell(Text(e.designsite)),
                            DataCell(Text(e.mntcr)),
                            DataCell(Text(e.mntd)),
                          ]))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
