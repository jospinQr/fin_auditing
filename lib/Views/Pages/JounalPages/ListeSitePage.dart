import 'package:fin_auditing/Functions/Fonctions.dart';
import 'package:fin_auditing/Models/Journal/SiteJM.dart';
import 'package:fin_auditing/ViewModel/Journal/ExerciceVM.dart';
import 'package:fin_auditing/ViewModel/Journal/AgenceJVM.dart';
import 'package:fin_auditing/ViewModel/Journal/SiteJVM.dart';
import 'package:fin_auditing/Views/Pages/JounalPages/ListeDateopPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return FutureBuilder(
        future: _site.loadSiteItems(_anneeExercice.getAnnee, widget.agence),
        builder: (context, snapshot) {
          if (_site.items.isEmpty) {
            _site.loadSiteItems(_anneeExercice.getAnnee, widget.agence);
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
                        builder: (context) => ListAnneePage(),
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

//
// class ListSitePage extends StatelessWidget {
//   ListSitePage({Key? key, required this.agence}) : super(key: key);
//
//   String agence;
//
//
//   @override
//   Widget build(BuildContext context) {
//     SiteJVM _site = Provider.of<SiteJVM>(context);
//
//     if (_site.items.isEmpty) {
//       _site.loadSiteItems(agence);
//       return const Scaffold(
//         body: Center(
//           child: CircularProgressIndicator(
//             backgroundColor: Colors.cyanAccent,
//           ),
//         ),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Choisissez un site"),
//         backgroundColor: const Color.fromARGB(255, 0, 129, 129),
//       ),
//       body: ListView.separated(
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(_site.items[index].codsite.toString()),
//             subtitle: Text(_site.items[index].designsite.toString()),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ListAnneePage(
//                     codeSite: _site.items[index].codsite.toString(),
//                     codeAgence: _site.items[index].codag.toString(),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return const Divider(
//             height: 1,
//             color: Color.fromARGB(255, 0, 129, 129),
//           );
//         },
//         itemCount: _site.items.length,
//       ),
//     );
//   }
// }
