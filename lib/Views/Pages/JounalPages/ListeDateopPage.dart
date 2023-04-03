import 'package:fin_auditing/ViewModel/Journal/DateopJVM.dart';
import 'package:fin_auditing/Views/Components/MyTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../../ViewModel/Journal/ExerciceVM.dart';
import 'package:fin_auditing/Views/Pages/JounalPages/ListeOprationPage.dart';

import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../ViewModel/Journal/SiteJVM.dart';

var rechercheController = TextEditingController();

class ListAnneePage extends StatelessWidget {
  ListAnneePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateopJVM _date = Provider.of<DateopJVM>(context);
    ExerciceVM _annee = Provider.of<ExerciceVM>(context);
    AgenceJVM _agence = Provider.of<AgenceJVM>(context);
    SiteJVM _site = Provider.of<SiteJVM>(context);

    return FutureBuilder(
        future: _date.loadDateItems(
            _site.getcodeSite, _annee.getAnnee, _agence.getCodeAgence),
        builder: (context, index) {

          if(_date.items.isEmpty){
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
              title: const Text("Selectionner une date"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_date.items[index].dateOperation.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListOprationPage(
                            codag: _agence.getCodeAgence,
                            codsite: _site.getcodeSite,
                            date: _date.items[index].dateOperation.toString()),
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
              itemCount: _date.items.length,
            ),
          );
        });
  }
}
