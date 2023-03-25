import 'dart:ffi';


import 'package:fin_auditing/ModelView/ApiServices/ApiConstants.dart';
import 'package:fin_auditing/ModelView/AgenceVM.dart';

import 'package:fin_auditing/Views/Items/activitesItme.dart';
import 'package:fin_auditing/Views/Pages/ArticlePage.dart';
import 'package:fin_auditing/Views/Pages/ClientPage.dart';
import 'package:fin_auditing/Views/Pages/ComptabilitePage.dart';
import 'package:fin_auditing/Views/Pages/PlanComptablePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<String> listSiteBo = <String>['Centre', 'Matanda', 'MGL', 'Bbo'];

class _HomePageState extends State<HomePage> {
  //liste des modules
  List items = [
    ["G-Commercial", "assets/A3.jpg", "40"],
    ["G-Stock", "assets/A1.jpg", "40"],
    ["G-Trésorerie", "assets/A9.jpg", "45"],
    ["G-Personel", "assets/A4.jpg", "50"],
    ["G-Immobilisation", "assets/A11.jpg", "50"],
    ["G-Comptes", "assets/A8.jpg", "50"],
  ];

  //le model des doneess necessaires pour cette page
  late AgenceVM myAgence;
  //valeur du dropDownButton pour les agences
  late String dropdownValueAgence=myAgence.items.map((e) => e.desinAge).first;
  //valeur du dropDownButton pour les sites
  late String dropdownValueSite=myAgence.itemsSite.map((e) => e.designsite).first;



  @override
  Widget build(BuildContext context) {
     myAgence = Provider.of<AgenceVM>(context);

    if (myAgence.items.isEmpty || myAgence.itemsSite.isEmpty) {
      myAgence.loadAgenceItems();
      myAgence.loadSiteItems();
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyanAccent,
          ),
        ),
      );
    }


    return  Scaffold(
      appBar: AppBar(
         title: Text("FinAuditing Mobile"),
         centerTitle: true,
         backgroundColor: const Color.fromARGB(255, 0, 129, 129),
         actions: [
            IconButton(onPressed: (){}, icon:Icon(Icons.help))
         ],
        leading:IconButton(onPressed: (){}, icon:Icon(Icons.person)),

      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Agence"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropdownValueAgence,
                      icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 129, 129)),
                      underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 0, 129, 129),
                      ),
                      onChanged: (value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueAgence = value!;
                        });
                      },
                      items: myAgence.items
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.desinAge,
                              child: Text(e.desinAge),
                            ),
                          )
                          .toList(),
                    )),
                    const Text("Site"),
                    DropdownButton<String>(
                      value: dropdownValueSite,
                      icon: const Icon(Icons.arrow_drop_down_circle_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 129, 129)),
                      underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 0, 129, 129),
                      ),
                      onChanged: (value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueSite = value!;
                        });
                      },
                      items: myAgence.itemsSite
                          .map((e) => DropdownMenuItem(
                                value: e.designsite,
                                child: Text(e.designsite),
                              ))
                          .toList(),
                    )
                  ],
                )),
            const Divider(
              height: 2,
              thickness: 0.2,
              indent: 20,
              endIndent: 0,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "Connecter vous à un module",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text("Activités commerciales")
                ],
              ),
            ),
            Expanded(
                child: GridView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: activitesItem(
                    name: items[index][0],
                    asset: items[index][1],

                    onPress: () => {
                      if (items[index][0] == "G-Comptes")
                        {
                          ouvrirPage(const ComptabilitePage()),
                        }
                      else if (items[index][0] == "Gestion articles")
                        {
                          ouvrirPage(const ArticlePage()),
                        }
                    },
                  ),
                );
              },
            )),
          ],
        ),
      ),


    );
  }

  void ouvrirPage(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
