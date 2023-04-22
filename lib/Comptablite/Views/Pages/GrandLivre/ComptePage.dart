import 'dart:convert';
import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicCosnt;
import 'package:fin_auditing/Comptablite/ViewModel/TypeRapportVM.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../../Public/Functions/MyExpextion.dart';
import '../../../../Public/Views/Pages/LoadingPage.dart';
import '../../../Constants/ApiConstants.dart';
import '../../../Models/GrandLivre/CompteM.dart';
import '../../../ViewModel/Gand Livre/CompteVM.dart';
import '../../../../Public/ViewModel/ExerciceVM.dart';
import 'Agence.dart';


class ComptePage extends StatefulWidget {
  const ComptePage({Key? key}) : super(key: key);

  @override
  State<ComptePage> createState() => _ComptePageState();
}

class _ComptePageState extends State<ComptePage> {

   late bool activeSearch;
   TextEditingController searchController=TextEditingController();
  List<CompteM> parseCompte(String responseBody) => List<CompteM>.from(
      jsonDecode(responseBody).map((x) => CompteM.fromjson(x))).toList();

  Future<List<CompteM>?> getGLCompte(
      String packageName, String urlEndpoint, String params) async {
    final url = Uri.parse(publicCosnt.AipConstants.baseUrl + urlEndpoint + params);
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }
    List<CompteM>? compte = parseCompte(response.body);
    return compte;
  }
@override
  void initState() {

    super.initState();
    activeSearch=false;
  }
  @override
  Widget build(BuildContext context) {
    var typeRapport = Provider.of<TypeRapportVM>(context);
    var annee = Provider.of<ExerciceVM>(context);
    var compte = Provider.of<CompteVM>(context);

    dynamic fetchByType() {
      if (typeRapport.getRapportName == "Patrimoine") {
        return getGLCompte("http", ApiConstants.grandLivreComptePatri,
            "codan=${annee.getAnnee}");
      } else if (typeRapport.getRapportName == "Exploitation") {
        return getGLCompte("http", ApiConstants.grandLivreCompteExploit,
            "codan=${annee.getAnnee}");
      } else if (typeRapport.getRapportName == "ACTIF" ||
          typeRapport.getRapportName == "PASSIF" ||
          typeRapport.getRapportName == "CHARGE" ||
          typeRapport.getRapportName == "PRODUIT") {
        return getGLCompte("http", ApiConstants.grandLivreCompteType,
            "codan=${annee.getAnnee}&&naturecpte=${typeRapport.getRapportName}");
      }
    }

    return FutureBuilder<List<CompteM>?>(
        future: fetchByType(),
        builder: (context, AsyncSnapshot<List<CompteM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }

          return Scaffold(
            appBar:_appBar(),



            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].numcpte),
                  subtitle: Text(snapshot.data![index].intitulecpte),
                  trailing: Text(snapshot.data![index].naturecpte),
                  onTap: () {
                    compte.setIntitCompte(snapshot.data![index].intitulecpte);
                    compte.setNumCompte(snapshot.data![index].numcpte);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ListAgencePageGrdl(),
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

  PreferredSizeWidget _appBar() {
    if (activeSearch) {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
        leading: Icon(Icons.search),
        title: TextField(
          controller: searchController,
          decoration:const InputDecoration(
            hintText: "Rechercher un compte",
          ),
          onChanged: (value){
            setState(() {

            });
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => setState(() => activeSearch = false),
          )
        ],
      );
    } else {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
        title: Text("Choisissez un compte"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearch = true),
          ),
        ],
      );
    }
  }

  Widget _drawer() {
    return Container();
  }
}



