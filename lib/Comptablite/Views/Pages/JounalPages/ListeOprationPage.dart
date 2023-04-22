import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicUrl;
import 'package:fin_auditing/Comptablite/ViewModel/TypeRapportVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Models/Journal/OperationM.dart';
import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../../ViewModel/Journal/OperationJVM.dart';
import '../../../ViewModel/Journal/SiteJVM.dart';
import 'JournalPage.dart';


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


  List<OperationM> parseOperation(String responseBody) => List<OperationM>.from(
      jsonDecode(responseBody).map((x) => OperationM.fromjson(x))).toList();

  Future<List<OperationM>?> fetchOPeration(String packageName, String urlEndPoint, String param) async {
    final url = Uri.parse(publicUrl.AipConstants.baseUrl + urlEndPoint + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<OperationM>? agence = parseOperation(response.body);
    return agence;
  }
  @override
  Widget build(BuildContext context) {
    ExerciceVM annee = Provider.of<ExerciceVM>(context);
    SiteJVM site=Provider.of<SiteJVM>(context);
    AgenceJVM agence=Provider.of<AgenceJVM>(context);
    OperationJVM opera = Provider.of<OperationJVM>(context);
    TypeRapportVM rapport=Provider.of<TypeRapportVM>(context);


    return FutureBuilder<List<OperationM>?>(
        future:
        rapport.getRapportName == "Journal Brouillard" ||
            rapport.getRapportName == "Journal Chronologique"?
        fetchOPeration("http",ApiConstants.Journaloperation,"dateopera=${widget.date}&&codsite=${widget.codsite}&&codan=${annee.getAnnee}&&codag=${widget.codag}&&obsopera=${rapport.getObservation}"):
        fetchOPeration("http",ApiConstants.jounrnaloprationtype,"dateopera=${widget.date}&&codsite=${widget.codsite}&&codan=${annee.getAnnee}&&codag=${widget.codag}&&typeopera=${rapport.getTypeJournal}"),
        builder: (context,AsyncSnapshot<List<OperationM>?> snapshot) {

          if(!snapshot.hasData){
            return const LoadingPage();
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
                  title: Text(snapshot.data![index].numopera.toString()),
                  subtitle: Text(snapshot.data![index].libopera.toString()),
                  onTap: () {
                    var op = OperationM(
                      numopera: snapshot.data![index].numopera.toString(),
                      libopera: snapshot.data![index].libopera.toString(),
                      mntcr: snapshot.data![index].mntcr.toString(),
                      mntd: snapshot.data![index].mntd.toString(),
                    );
                    opera.setOpera(op);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JournalPage(
                          numOperation:
                          snapshot.data![index].numopera.toString(),
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
              itemCount:snapshot.data!.length,
            ),
          );
        });
  }
}
