import 'dart:convert';
import 'dart:developer';
import 'package:fin_auditing/Comptablite/Constants/ApiConstants.dart';
import 'package:fin_auditing/Comptablite/ViewModel/TypeRapportVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Models/Journal/DebitCredit.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';
import '../../../Models/Journal/SiteJM.dart';
import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../../ViewModel/Journal/SiteJVM.dart';
import 'ListeDateopPage.dart';

class ListSitePage extends StatefulWidget {
  ListSitePage({Key? key, required this.agence}) : super(key: key);
  String agence;

  @override
  State<ListSitePage> createState() => _ListSitePageState();
}

class _ListSitePageState extends State<ListSitePage> {
  List<SiteJM> parseJournal(String responseBody) =>
      List<SiteJM>.from(jsonDecode(responseBody).map((x) => SiteJM.fromjson(x)))
          .toList();
  Future<List<SiteJM>?> fetchSite(String packageName, String urlEndPoind, String param) async {
    final url = Uri.parse(publicConst.AipConstants.baseUrl + urlEndPoind + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<SiteJM>? _site = parseJournal(response.body);
    return _site;
  }

  @override
  Widget build(BuildContext context) {
    SiteJVM site = Provider.of<SiteJVM>(context);
    ExerciceVM anneeExercice = Provider.of<ExerciceVM>(context);
    TypeRapportVM rapport = Provider.of<TypeRapportVM>(context);
    return FutureBuilder<List<SiteJM>?>(
        future:
        rapport.getRapportName == "Journal Brouillard" ||
            rapport.getRapportName == "Journal Chronologique"?
        fetchSite("http",ApiConstants.Journalgroupsite,"codan=${anneeExercice.getAnnee}&&codag=${widget.agence}&&obsopera=${rapport.getObservation}")
        :fetchSite("http",ApiConstants.journalgroupsiteType,"codan=${anneeExercice.getAnnee}&&codag=${widget.agence}&&typeopera=${rapport.getTypeJournal}"),
        builder: (context,AsyncSnapshot<List<SiteJM>?> snapshot) {
          if(!snapshot.hasData){
            return const LoadingPage();
          }else if(snapshot.data==null){
            return const Center(child:Text("Pas d'info"));
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Choisissez un site"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
            ),
            body:ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].codsite),
                  subtitle: Text(snapshot.data![index].designsite),
                  onTap: () {
                    site.setCodeSite(snapshot.data![index].codsite);
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
              itemCount: snapshot.data?.length??0,
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
        Uri.parse(publicConst.AipConstants.baseUrl + ApiConstants.journalTotalSite + param);
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
        publicConst.AipConstants.baseUrl + ApiConstants.journalTotalSiteType + param);
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

    return FutureBuilder(
        future: rapport.getRapportName == "Journal Brouillard" ||
                rapport.getRapportName == "Journal Chronologique"
            ? getDebitCredit("http",
                "codan=${annee.getAnnee}&&codag=${agence.getCodeAgence}&&obsopera=${observation.getObservation}")
            : getDebitCreditType("http",
                "codan=${annee.getAnnee}&&codag=${agence.getCodeAgence}&&typeopera=${rapport.getTypeJournal}"),
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
