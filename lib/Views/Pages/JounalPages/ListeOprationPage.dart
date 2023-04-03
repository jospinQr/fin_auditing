import 'package:fin_auditing/Functions/Fonctions.dart';
import 'package:fin_auditing/Models/Journal/OperationM.dart';
import 'package:fin_auditing/Models/Site.dart';
import 'package:fin_auditing/ViewModel/Journal/AgenceJVM.dart';
import 'package:fin_auditing/ViewModel/Journal/OperationJVM.dart';
import 'package:fin_auditing/ViewModel/Journal/SiteJVM.dart';
import 'package:fin_auditing/Views/Pages/JounalPages/JournalPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/Journal/ExerciceVM.dart';

class ListOprationPage extends StatefulWidget {
  const ListOprationPage(
      {Key? key,
      required this.codag,
      required this.codsite,
      required this.date})
      : super(key: key);
  final String codag;
  final String codsite;
  final String date;

  @override
  State<ListOprationPage> createState() => _ListOprationPageState();
}

class _ListOprationPageState extends State<ListOprationPage> {
  @override
  Widget build(BuildContext context) {
    ExerciceVM _annee = Provider.of<ExerciceVM>(context);
    OperationJVM _opera = Provider.of<OperationJVM>(context);

    return FutureBuilder(
        future: _opera.loadopItems(
            widget.date, widget.codsite, _annee.getAnnee, widget.codag),
        builder: (context, snapshot) {

          if(_opera.itemOpera.isEmpty){
            _opera.loadopItems(
                widget.date, widget.codsite, _annee.getAnnee, widget.codag);
            return Scaffold(
              appBar: AppBar(
                title: const Text("Chargement en cours..."),
                backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              ),
              body:const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.cyanAccent,
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Selectionner une operation"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_opera.itemOpera[index].numopera.toString()),
                  subtitle: Text(_opera.itemOpera[index].libopera.toString()),
                  onTap: () {
                    var op = OperationM(
                      numopera: _opera.itemOpera[index].numopera.toString(),
                      libopera: _opera.itemOpera[index].libopera.toString(),
                      mntcr: _opera.itemOpera[index].mntcr.toString(),
                      mntd: _opera.itemOpera[index].mntd.toString(),
                    );
                    _opera.setOpera(op);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JournalPage(
                          numOperation:
                              _opera.itemOpera[index].numopera.toString(),
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
              itemCount: _opera.itemOpera.length,
            ),
          );
        });
  }
}
