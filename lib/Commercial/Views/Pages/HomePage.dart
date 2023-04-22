import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Commercial/Constants/RapportConstants.dart';
import 'package:fin_auditing/Commercial/Views/Pages/ArticlePage.dart';
import 'package:fin_auditing/Commercial/Views/Pages/CatArticlePage.dart';
import 'package:fin_auditing/Commercial/Views/Pages/FournisseurPage.dart';
import 'package:fin_auditing/Commercial/Views/Pages/PrixPage.dart';
import 'package:fin_auditing/Commercial/Views/Pages/StockAlert.dart';
import 'package:fin_auditing/Public/Functions/Fonctions.dart';
import 'package:fin_auditing/Public/ViewModel/AgenceVM.dart';
import 'package:fin_auditing/Public/ViewModel/SiteVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Public/ViewModel/ExerciceVM.dart';
import '../../../Public/Views/Drawer/myHeaderDrawer.dart';
import '../../../Public/Views/Pages/LoadingPage.dart';
import 'ClientPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var listTypeRap = RapportConstants.rapportCommercial;

class _HomePageState extends State<HomePage> {
  late ExerciceVM _exercice;
  late AgenceVM _site;

  int currentIndex = 0;
  late var dropdownValueExec = _exercice.items.map((e) => e.annee).first;
  late var dropdownValueSite = _site.itemsSite.map((e) => e.codsite).first;

  //ce drop va appaart dans un alertdialogue
  late var dropdownValueAgence = _site.items.map((e) => e.codAge).first;

  var dropTypeRapValue = listTypeRap.first;

  @override
  Widget build(BuildContext context) {
    var agence = Provider.of<AgenceVM>(context);
    var site = Provider.of<SiteVM>(context);

    final drawerItems = Scaffold(
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
      ),
      body: ListView(
        children: [
          myHeaderDrawer(),
          ListTile(
            title: const Text("Clients"),
            leading: const Icon(
              Icons.people_alt_rounded,
              color: Color.fromARGB(255, 0, 129, 129),
            ),
            onTap: () {
              setState(() {
                currentIndex = 1;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Choisissez une agence",
                        style: TextStyle(fontSize: 15),
                      ),
                      content: Container(
                        child: SingleChildScrollView(
                          child: (Column(
                            children: [
                              DropdownButton<String>(
                                  value: dropdownValueAgence,
                                  icon: const Icon(
                                      Icons.arrow_drop_down_circle_sharp),
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 129, 129)),
                                  underline: Container(
                                    height: 2,
                                    color:
                                        const Color.fromARGB(255, 0, 129, 129),
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValueAgence = value!;
                                    });
                                  },
                                  items: _site.items
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.codAge,
                                          child: Text(e.codAge),
                                        ),
                                      )
                                      .toList()),
                            ],
                          )),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClientPage(
                                        codAg: dropdownValueAgence)));
                          },
                          icon: Icon(Icons.check_circle,
                              color: Color.fromARGB(255, 0, 129, 129)),
                        ),
                      ],
                    );
                  });
              // setState(() {
              //   currentIndex = 1;
              // });
              // Navigator.of(context).push(_pages(currentIndex));
            },
          ),
          ListTile(
            title: const Text("Fournisseurs"),
            leading: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 0, 129, 129),
            ),
            onTap: () {
              setState(() {
                currentIndex = 2;
              });

              Navigator.of(context).push(_pages(currentIndex));
            },
          ),
          ListTile(
            title: const Text("Articles"),
            leading: const Icon(
              Icons.production_quantity_limits_rounded,
              color: Color.fromARGB(255, 0, 129, 129),
            ),
            onTap: () {
              setState(() {
                currentIndex = 3;
              });
              Navigator.of(context).push(_pages(currentIndex));
            },
          ),
          ListTile(
            title: Text("Prix des Articles"),
            leading: Icon(
              Icons.monetization_on_rounded,
              color: Color.fromARGB(255, 0, 129, 129),
            ),
            onTap: () {
              setState(() {
                currentIndex = 4;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Choisissez une agence",
                        style: TextStyle(fontSize: 15),
                      ),
                      content: Container(
                        child: SingleChildScrollView(
                          child: (Column(
                            children: [
                              DropdownButton<String>(
                                  value: dropdownValueAgence,
                                  icon: const Icon(
                                      Icons.arrow_drop_down_circle_sharp),
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 129, 129)),
                                  underline: Container(
                                    height: 2,
                                    color:
                                        const Color.fromARGB(255, 0, 129, 129),
                                  ),
                                  onChanged: (String? value) {
                                    agence.setCodAg(value!);
                                    setState(() {
                                      dropdownValueAgence = value;
                                    });
                                  },
                                  items: _site.items
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.codAge,
                                          child: Text(e.desinAge),
                                        ),
                                      )
                                      .toList()),
                            ],
                          )),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PrixPage(codAg: agence.getCodAg)));
                          },
                          icon: Icon(Icons.check_circle,
                              color: Color.fromARGB(255, 0, 129, 129)),
                        ),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            title: Text("Stocks d'alert"),
            leading: Icon(
              Icons.add_alert_sharp,
              color: Color.fromARGB(255, 0, 129, 129),
            ),
            onTap: () {
              setState(() {
                currentIndex = 4;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(
                        "Choisissez une agence",
                        style: TextStyle(fontSize: 15),
                      ),
                      content: Container(
                        child: SingleChildScrollView(
                          child: (Column(
                            children: [
                              DropdownButton<String>(
                                  value: dropdownValueSite,
                                  icon: const Icon(
                                      Icons.arrow_drop_down_circle_sharp),
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 0, 129, 129)),
                                  underline: Container(
                                    height: 2,
                                    color:
                                        const Color.fromARGB(255, 0, 129, 129),
                                  ),
                                  onChanged: (String? value) {
                                    site.setCodeSite(value!);
                                    setState(() {
                                      dropdownValueSite = value;
                                    });
                                  },
                                  items: _site.itemsSite
                                      .map(
                                        (e) => DropdownMenuItem(
                                          value: e.codsite,
                                          child: Text(e.codsite),
                                        ),
                                      )
                                      .toList()),
                            ],
                          )),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            if(site.getCodeSite==""){
                               site.setCodeSite(dropdownValueSite);
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => StockAlertPage(
                                           codSite: site.getCodeSite)));
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StockAlertPage(
                                        codSite: site.getCodeSite)));
                          },
                          icon: Icon(Icons.check_circle,
                              color: Color.fromARGB(255, 0, 129, 129)),
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
    _exercice = Provider.of<ExerciceVM>(context);
    _site = Provider.of<AgenceVM>(context);
    if (_exercice.items.isEmpty || _site.items.isEmpty) {
      _exercice.loadListeExercice();
      _site.loadSiteItems();
      return const LoadingPage();
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Aperçu des rapports commerciaux",
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.lock),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app_rounded),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                  margin: EdgeInsets.all(20),
                  elevation: 2,
                  borderOnForeground: true,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Type de rapport",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                                value: dropTypeRapValue,
                                icon: const Icon(
                                    Icons.arrow_drop_down_circle_sharp),
                                elevation: 16,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 129, 129)),
                                underline: Container(
                                  height: 2,
                                  color: const Color.fromARGB(255, 0, 129, 129),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {});
                                },
                                items: listTypeRap
                                    .map<DropdownMenuItem<String>>(
                                        (dynamic value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList()),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Exercice",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 50),
                            DropdownButton<String>(
                                value: dropdownValueExec,
                                icon: const Icon(
                                    Icons.arrow_drop_down_circle_sharp),
                                elevation: 16,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 129, 129)),
                                underline: Container(
                                  height: 2,
                                  color: const Color.fromARGB(255, 0, 129, 129),
                                ),
                                onChanged: (String? value) {
                                  // This is called when the user selects an item.
                                  setState(() {
                                    _exercice.setanne(value!);
                                    dropdownValueExec = value;
                                  });
                                },
                                items: _exercice.items
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.annee,
                                        child: Text(e.annee),
                                      ),
                                    )
                                    .toList()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Site",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 50),
                            DropdownButton<String>(
                              value: dropdownValueSite,
                              icon: const Icon(
                                  Icons.arrow_drop_down_circle_sharp),
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
                                _site.setCodAg(value!);
                              },
                              items: _site.itemsSite
                                  .map((e) => DropdownMenuItem(
                                        value: e.codsite,
                                        child: Text(e.codsite),
                                      ))
                                  .toList(),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[200],
        child: drawerItems,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 129, 129),
          onPressed: () {},
          child: Spin(child: const Icon(Icons.remove_red_eye_outlined))),
    );
  }
}

class _pages extends MaterialPageRoute<void> {
  _pages(int id)
      : super(builder: (BuildContext context) {
          if (id == 2) {
            return const FournisseurPage();
          } else if (id == 3) {
            return const CatArticlePage();
          } else if (id == 4) {}

          return const FournisseurPage();
        });
}
