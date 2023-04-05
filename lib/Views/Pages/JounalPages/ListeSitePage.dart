import 'package:fin_auditing/Functions/Fonctions.dart';
import 'package:fin_auditing/Models/Journal/SiteJM.dart';
import 'package:fin_auditing/ViewModel/Journal/ExerciceVM.dart';
import 'package:fin_auditing/ViewModel/Journal/AgenceJVM.dart';
import 'package:fin_auditing/ViewModel/Journal/SiteJVM.dart';
import 'package:fin_auditing/ViewModel/TypeRapportVM.dart';
import 'package:fin_auditing/Views/Pages/JounalPages/ListeDateopPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../LoadingPage.dart';

class ListSitePage extends StatefulWidget {
  ListSitePage({Key? key, required this.agence}) : super(key: key);
  String agence;

  @override
  State<ListSitePage> createState() => _ListSitePageState();
}

class _ListSitePageState extends State<ListSitePage> {
  @override
  Widget build(BuildContext context) {
    SiteJVM _site = Provider.of<SiteJVM>(context);
    ExerciceVM _anneeExercice = Provider.of<ExerciceVM>(context);
    TypeRapportVM _typeRap=Provider.of<TypeRapportVM>(context);
    return FutureBuilder(
        future: _site.loadSiteItems(_anneeExercice.getAnnee, widget.agence,_typeRap.getObservation),
        builder: (context, snapshot) {
          if (_site.items.isEmpty) {
            _site.loadSiteItems(_anneeExercice.getAnnee, widget.agence,_typeRap.getObservation);
            return LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Choisissez un site"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_site.items[index].codsite.toString()),
                  subtitle: Text(_site.items[index].designsite.toString()),
                  onTap: () {
                    _site.setCodeSite(_site.items[index].codsite.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListDatePage(),
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
              itemCount: _site.items.length,
            ),
          );
        });
  }
}
