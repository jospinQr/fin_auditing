import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../ViewModel/Journal/DateopJVM.dart';
import '../../../ViewModel/Journal/ExerciceVM.dart';
import '../../../ViewModel/Journal/SiteJVM.dart';
import '../../../ViewModel/TypeRapportVM.dart';
import '../LoadingPage.dart';
import 'ListeOprationPage.dart';

class ListDatePage extends StatefulWidget {
  const ListDatePage({Key? key}) : super(key: key);

  @override
  State<ListDatePage> createState() => _ListDatePageState();
}

class _ListDatePageState extends State<ListDatePage> {
  late _MySearchDelegate _delegate;

  @override
  Widget build(BuildContext context) {
    DateopJVM _date = Provider.of<DateopJVM>(context);
    ExerciceVM _annee = Provider.of<ExerciceVM>(context);
    AgenceJVM _agence = Provider.of<AgenceJVM>(context);
    SiteJVM _site = Provider.of<SiteJVM>(context);
    TypeRapportVM _typeRapp = Provider.of<TypeRapportVM>(context);

    return FutureBuilder(
        future: _date.loadDateItems(_site.getcodeSite, _annee.getAnnee,
            _agence.getCodeAgence, _typeRapp.getObservation),
        builder: (context, index) {
          if (_date.items.isEmpty) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Selectionner une date"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              actions: [
                IconButton(
                  onPressed: ()async {
                    final String? selected=await showSearch<String>(context:context,delegate:_delegate,);
                  },
                  icon: const Icon(Icons.search),

                )
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

class _MySearchDelegate extends SearchDelegate<String> {
  final List<String> _words;
  final List<String> _history;

  _MySearchDelegate(List<String> word)
      : _words = word,
        _history = <String>['joe', 'joe'],
        super();

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Vous avez selectionner"),
            GestureDetector(
              onTap: () {
                close(context, query);
              },
              child: Text(query),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<String> suggestion = this.query.isEmpty
        ? _history
        : _words.where((element) => element.startsWith(query));
    return _suggestionList(
        query: query,
        suggestions: suggestion.toList(),
        onSelected: (String suggestion) {
          this.query = suggestion;
          this._history.insert(0, suggestion);
          showResults(context);
        });
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      if (query.isEmpty)
        IconButton(
          tooltip: 'serv',
          icon: Icon(Icons.mic),
          onPressed: () {},
        )
      else
        IconButton(
          tooltip: 'clear',
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }
}

class _suggestionList extends StatelessWidget {
  const _suggestionList(
      {required this.suggestions,
      required this.query,
      required this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int i) {
      final String suggestion = suggestions[i];
      return ListTile(
        title: Text(suggestion.substring(0, query.length)),
      );
    });
  }
}

//
// class ListAnneePage extends StatelessWidget {
//   ListAnneePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     DateopJVM _date = Provider.of<DateopJVM>(context);
//     ExerciceVM _annee = Provider.of<ExerciceVM>(context);
//     AgenceJVM _agence = Provider.of<AgenceJVM>(context);
//     SiteJVM _site = Provider.of<SiteJVM>(context);
//     TypeRapportVM _typeRapp=Provider.of<TypeRapportVM>(context);
//
//     return FutureBuilder(
//         future: _date.loadDateItems(
//             _site.getcodeSite, _annee.getAnnee, _agence.getCodeAgence,_typeRapp.getObservation),
//         builder: (context, index) {
//
//           if(_date.items.isEmpty){
//             return const LoadingPage();
//           }
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text("Selectionner une date"),
//               backgroundColor: const Color.fromARGB(255, 0, 129, 129),
//               actions: [
//                 IconButton(onPressed: () {}, icon: const Icon(Icons.search))
//               ],
//             ),
//             body: ListView.separated(
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(_date.items[index].dateOperation.toString()),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ListOprationPage(
//                             codag: _agence.getCodeAgence,
//                             codsite: _site.getcodeSite,
//                             date: _date.items[index].dateOperation.toString()),
//                       ),
//                     );
//                   },
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider(
//                   height: 1,
//                   color: Color.fromARGB(255, 0, 129, 129),
//                 );
//               },
//               itemCount: _date.items.length,
//             ),
//           );
//         });
//   }
// }
