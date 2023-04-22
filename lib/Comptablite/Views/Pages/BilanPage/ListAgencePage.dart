import 'dart:convert';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Models/AgenceM.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../ViewModel/TypeRapportVM.dart';
import '../../../Constants/ApiConstants.dart';

import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import '../../../../Public/Constants/ApiConatants.dart' as publicApi;
import 'ListNaturePage.dart';

class ListAgenceBilanPage extends StatefulWidget {
  const ListAgenceBilanPage({Key? key}) : super(key: key);

  @override
  State<ListAgenceBilanPage> createState() => _ListAgenceBilanPageState();
}

class _ListAgenceBilanPageState extends State<ListAgenceBilanPage> {
  List<Agence> parseAgence(String responseBody) =>
      List<Agence>.from(jsonDecode(responseBody).map((x) => Agence.fromjson(x)))
          .toList();

  Future<List<Agence>?> fetchAgence(
      String packageName, String urlEndPoint, String param) async {
    final url = Uri.parse(publicApi.AipConstants.baseUrl + urlEndPoint + param);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<Agence>? agence = parseAgence(response.body);
    return agence;
  }

  @override
  Widget build(BuildContext context) {
    AgenceJVM agence = Provider.of<AgenceJVM>(context);
    TypeRapportVM rapport = Provider.of<TypeRapportVM>(context);
    ExerciceVM exercice = Provider.of<ExerciceVM>(context);

    return FutureBuilder<List<Agence>?>(
        future: rapport.getRapportName == "Bilan general"
            ? fetchAgence(
                "http", ApiConstants.bilanAgence, "codan=${exercice.getAnnee}")
            : fetchAgence("http", "", ""),
        builder: (context, AsyncSnapshot<List<Agence>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text("Choisissez une agence"),
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].codAge.toString()),
                  subtitle: Text(snapshot.data![index].desinAge.toString()),
                  onTap: () {
                    agence.setCodAge(snapshot.data![index].codAge.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListNaturePage(),
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
                // showModalBottomSheet(
                //   context: context,
                //   builder: (context) => const BottomSheet(),
                // );
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

//
// class _BottomSheetState extends State<BottomSheet> {
//   List<Agence> parseAgence(String responseBody) =>
//       List<Agence>.from(jsonDecode(responseBody).map((x) => Agence.fromjson(x)))
//           .toList();
//
//   Future<List<Agence>?> fetchSite(
//       String packageName, String urlEndPoint,String param) async {
//     final url = Uri.parse(ApiConstants.baseUrl + urlEndPoint+param);
//     final response = await http.get(url);
//
//     if (response.statusCode != 200) {
//       log(response.statusCode.toString());
//       throw PackageRecupererException(packageName: packageName);
//     }
//     List<Agence>? agence = parseAgence(response.body);
//     return agence;
//   }
//   @override
//   Widget build(BuildContext context) {
//     AgenceJVM agence = Provider.of<AgenceJVM>(context);
//     TypeRapportVM rapport = Provider.of<TypeRapportVM>(context);
//     ExerciceVM exercice = Provider.of<ExerciceVM>(context);
//
//     return FutureBuilder(
//          future: rapport.getRapportName == "Bilan general"
//     ? fetchSite("http", ApiConstants.bilanAgence,"codan=${exercice.getAnnee}")
//         : fetchSite("http","",""),
//         builder: (index, snap) {
//           if (!snap.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//           return Container(
//               height: 150,
//               padding: EdgeInsets.all(20),
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 0, 129, 129),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(50),
//                   bottomRight: Radius.circular(50),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text("Solde année N",
//                           style: TextStyle(
//                               color: Colors.white60,
//                               fontWeight: FontWeight.bold)),
//                       Text("Solde année N-1",
//                           style: TextStyle(
//                               color: Colors.white60,
//                               fontWeight: FontWeight.bold))
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       BounceInLeft(
//                         child: Text(
//                           snap.data![0],
//                           style: const TextStyle(color: Colors.white60),
//                         ),
//                       ),
//                       BounceInRight(
//                         child:const Text(
//                           "",
//                           style: const TextStyle(color: Colors.white60),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ));
//         });
//   }
// }
//
