import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as pulicConst;
import '../../../Models/Bilan/Nature.dart';
import '../../../ViewModel/Bilan/NatureVM.dart';
import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../../ViewModel/TypeRapportVM.dart';

class ListNaturePage extends StatefulWidget {
  const ListNaturePage({Key? key}) : super(key: key);

  @override
  State<ListNaturePage> createState() => _ListNaturePageState();
}

class _ListNaturePageState extends State<ListNaturePage> {
  List<Nature> parseNature(String responseBody) =>
      List<Nature>.from(jsonDecode(responseBody).map((x) => Nature.fromjson(x)))
          .toList();

  Future<List<Nature>?> fetchNature(
      String packageName, String urlEndPoint, String param) async {
    final url = Uri.parse(pulicConst.AipConstants.baseUrl+ urlEndPoint + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<Nature>? nature = parseNature(response.body);
    return nature;
  }

  @override
  Widget build(BuildContext context) {
    var agence = Provider.of<AgenceJVM>(context);
    var rapport = Provider.of<TypeRapportVM>(context);
    var exercice = Provider.of<ExerciceVM>(context);
    var nature = Provider.of<NatureVM>(context);

    return FutureBuilder<List<Nature>?>(
        future: rapport.getRapportName == "Bilan general"
            ? fetchNature("http", ApiConstants.bilanNature,
                "codan=${exercice.getAnnee}&&codag=${agence.getCodeAgence}")
            : fetchNature("http", "", ""),
        builder: (context, AsyncSnapshot<List<Nature>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Choisissez une nature"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].designation),

                  onTap: () {
                    nature.setDesignation(snapshot.data![index].designation);
                    nature.setSoldN(snapshot.data![index].SoldN);
                    nature.setSoldn1(snapshot.data![index].SoldN);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ListSitePage(
                    //       agence: agence.getCodeAgence,
                    //     ),
                    //   ),
                    // );
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
                  builder: (context) =>BottomSheet(),
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
  List<Nature> parseNature(String responseBody) =>
      List<Nature>.from(jsonDecode(responseBody).map((x) => Nature.fromjson(x)))
          .toList();

  Future<List<Nature>?> fetchNature(
      String packageName, String urlEndPoint, String param) async {
    final url = Uri.parse(pulicConst.AipConstants.baseUrl + urlEndPoint + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<Nature>? nature = parseNature(response.body);
    return nature;
  }
  @override
  Widget build(BuildContext context) {
    AgenceJVM agence = Provider.of<AgenceJVM>(context);
    TypeRapportVM rapport = Provider.of<TypeRapportVM>(context);
    ExerciceVM exercice = Provider.of<ExerciceVM>(context);

    return FutureBuilder<List<Nature>?>(
        future: rapport.getRapportName == "Bilan general"
            ? fetchNature("http", ApiConstants.bilanNature,
            "codan=${exercice.getAnnee}&&codag=${agence.getCodeAgence}")
            : fetchNature("http", "", ""),
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
                      Text("Solde année N",
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold)),
                      Text("Solde année N-1",
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
                          snap.data![0].SoldN,
                          style: const TextStyle(color: Colors.white60),
                        ),
                      ),
                      BounceInRight(
                        child: Text(
                          snap.data![0].SoldN1,
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


