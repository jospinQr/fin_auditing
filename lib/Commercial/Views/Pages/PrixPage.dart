import 'dart:convert';
import 'dart:developer';
import 'package:fin_auditing/Commercial/Models/PrixM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Public/Functions/MyExpextion.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:fin_auditing/Commercial/Constants/ApiConstants.dart'
    as comConst;
import 'package:http/http.dart' as http;

import '../../../Public/ViewModel/AgenceVM.dart';
import '../../../Public/Views/Pages/LoadingPage.dart';

class PrixPage extends StatefulWidget {
  const PrixPage({Key? key, required this.codAg}) : super(key: key);
  final String codAg;

  @override
  State<PrixPage> createState() => _PrixPageState();
}

class _PrixPageState extends State<PrixPage> {
  List<PrixM> parseClient(String responseBody) =>
      List<PrixM>.from(jsonDecode(responseBody).map((x) => PrixM.fromjson(x)));

  Future<List<PrixM>?> fetchPrix(String packageName) async {
    final url = Uri.parse(
        "${publicConst.AipConstants.baseUrl}${comConst.ApiConstants.prixUrlEndPoint}codag=${widget.codAg}");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<PrixM> prix = parseClient(response.body);

    return prix;
  }

  @override
  Widget build(BuildContext context) {
    var agence = Provider.of<AgenceVM>(context);
    return FutureBuilder(
        future: fetchPrix("http"),
        builder: (context, AsyncSnapshot<List<PrixM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              title: Text("Prix des article agence ${agence.getCodAg}"),
            ),
            body: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    elevation: 0.6,
                    child: Column(
                      children: [
                        Text(
                          snapshot.data![index].designart,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 129, 129),
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('UnitP'),
                                  Text(snapshot.data![index].unitppal),
                                  Text("${snapshot.data![index].prixunitppal} \$"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sunit1'),
                                  Text(snapshot.data![index].sunit1),
                                  Text("${snapshot.data![index].prixsunit1} \$"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sunit2'),
                                  Text(snapshot.data![index].sunit2),
                                  Text("${snapshot.data![index].prixsunit2} \$"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Sunit3'),
                                  Text(snapshot.data![index].sunit3),
                                  Text("${snapshot.data![index].prixsunit3} \$"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
