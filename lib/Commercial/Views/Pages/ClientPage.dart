import 'dart:convert';
import 'dart:developer';

import 'package:fin_auditing/Commercial/Models/ClientM.dart';

import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:fin_auditing/Commercial/Constants/ApiConstants.dart' as comConst;
import '../../../Public/ApiServices/ClientApi.dart';
import '../../../Public/Functions/MyExpextion.dart';
import '../../../Public/Views/Pages/LoadingPage.dart';
import 'DetailClientPage.dart';
import 'package:http/http.dart' as http;

class ClientPage extends StatefulWidget {
  const ClientPage({super.key,required this.codAg});
 final String codAg;

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  List<ClientM> parseClient(String responseBody) => List<ClientM>.from(
      jsonDecode(responseBody).map((x) => ClientM.fromjson(x)));

  Future<List<ClientM>?> fetchClient(String packageName) async {
    final url = Uri.parse("${publicConst.AipConstants.baseUrl}${comConst.ApiConstants.clientEndPoint}codag=${widget.codAg}");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<ClientM> debitCredit = parseClient(response.body);

    return debitCredit;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchClient("http"),
        builder: (context, AsyncSnapshot<List<ClientM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              title: const Text("List des clients"),
              actions: <Widget>[
                IconButton(onPressed: (){fetchClient("http");}, icon: Icon(Icons.refresh))
              ],
            ),
            body:snapshot.data!.isNotEmpty? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 0, 129, 129),
                    child: Text(snapshot.data![index].nomcli[0]),
                  ),
                  title: Text(snapshot.data![index].nomcli),
                  subtitle: Text(snapshot.data![index].numtelcli),
                  trailing:Text(snapshot.data![index].agence) ,
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailClientPage(
                          client: snapshot.data![index],
                        ),
                      ),
                    )
                  },
                );
              },

            ):const Center(child: Text("Pas de clients dans cette liste"),),
          );
        });
  }
}
