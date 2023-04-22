import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import '../../../Models/Journal/DateOpJ.dart';
import '../../../Models/Journal/DebitCredit.dart';
import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../ViewModel/Journal/DateopJVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../../ViewModel/Journal/SiteJVM.dart';
import '../../../ViewModel/TypeRapportVM.dart';

import 'ListeOprationPage.dart';

class ListDatePage extends StatefulWidget {
  const ListDatePage({Key? key}) : super(key: key);

  @override
  State<ListDatePage> createState() => _ListDatePageState();
}

class _ListDatePageState extends State<ListDatePage> {
  late _MySearchDelegate _delegate;

  List<DateOJM> parseDateOp(String responseBody) => List<DateOJM>.from(
      jsonDecode(responseBody).map((x) => DateOJM.fromjson(x))).toList();

  Future<List<DateOJM>?> fetchDateOP(
      String packageName, String urlEndPoint, String param) async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl + urlEndPoint + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<DateOJM>? agence = parseDateOp(response.body);
    return agence;
  }

  @override
  Widget build(BuildContext context) {
    ExerciceVM annee = Provider.of<ExerciceVM>(context);
    AgenceJVM agence = Provider.of<AgenceJVM>(context);
    SiteJVM site = Provider.of<SiteJVM>(context);
    TypeRapportVM rapport = Provider.of<TypeRapportVM>(context);

    return FutureBuilder<List<DateOJM>?>(
        future: rapport.getRapportName == "Journal Brouillard" ||
                rapport.getRapportName == "Journal Chronologique"
            ? fetchDateOP("http", ApiConstants.Journaldateop,
                "codsite=${site.getcodeSite}&&codan=${annee.getAnnee}&&codag=${agence.getCodeAgence}&&obsopera=${rapport.getObservation}")
            : fetchDateOP("http", ApiConstants.journaldateopType,
                "typeopera=${rapport.getTypeJournal}&&codan=${annee.getAnnee}&&codag=${agence.getCodeAgence}&&codsite=${site.getcodeSite}"),
        builder: (context, AsyncSnapshot<List<DateOJM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Selectionner une date"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              actions: [
                IconButton(
                  onPressed: () async {
                    final String? selected = await showSearch<String>(
                      context: context,
                      delegate: _delegate,
                    );
                  },
                  icon: const Icon(Icons.search),
                )
              ],
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].dateOperation.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListOprationPage(
                            codag: agence.getCodeAgence,
                            codsite: site.getcodeSite,
                            date: snapshot.data![index].dateOperation.toString()),
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
            ),
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
    final url =
        Uri.parse(publicConst.AipConstants.baseUrl+ ApiConstants.journalTotalDate + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<DebitCredit> _clients = parseClient(response.body);

    return _clients;
  }

  Future<List<DebitCredit>?> getDebitCreditType(
      String packageName, String param) async {
    final url = Uri.parse(
        publicConst.AipConstants.baseUrl + ApiConstants.journalTotalDateType + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<DebitCredit> _clients = parseClient(response.body);

    return _clients;
  }

  @override
  Widget build(BuildContext context) {
    var annee = Provider.of<ExerciceVM>(context);
    var observation = Provider.of<TypeRapportVM>(context);
    var rapport = Provider.of<TypeRapportVM>(context);
    var agence = Provider.of<AgenceJVM>(context);
    var site = Provider.of<SiteJVM>(context);

    return FutureBuilder(
        future: rapport.getRapportName == "Journal Brouillard" ||
                rapport.getRapportName == "Journal Chronologique"
            ? getDebitCredit("http",
                "codan=${annee.getAnnee}&&codag=${agence.getCodeAgence}&&codsite=${site.getcodeSite}&&obsopera=${observation.getObservation}")
            : getDebitCreditType("http",
                "codan=${annee.getAnnee}&&codag=${agence.getCodeAgence}&&codsite=${site.getcodeSite}&&typeopera=${rapport.getTypeJournal}"),
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
