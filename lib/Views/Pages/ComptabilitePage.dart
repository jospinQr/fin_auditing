import 'package:fin_auditing/Views/Drawer/myHeaderDrawer.dart';
import 'package:fin_auditing/Views/Pages/JounalPages/ListAgencePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fin_auditing/Models/RapportM.dart';
import '../../ModelView/AgenceVM.dart';
import '../../Functions/Fonctions.dart';
import 'package:fin_auditing/Views/Pages/RapportPage.dart';
import 'package:intl/intl.dart';

import '../../ModelView/JournalVM.dart';

class ComptabilitePage extends StatefulWidget {
  const ComptabilitePage({Key? key}) : super(key: key);

  @override
  State<ComptabilitePage> createState() => _ComptabilitePageState();
}

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

var listTypeRap = Rapport.typeRapport;
var listRapport = Rapport.RapportEnregistrement;

List<String> listAnnee = <String>['2022', '2023'];

enum choixTriCompte { numero, intitule }

class _ComptabilitePageState extends State<ComptabilitePage> {
  var currentDrawer = DrawerSection.Apercu;
  late List listToutRapport = listRapport;
  var dropTypeRapValue = listTypeRap.first;
  late String dropRapport = listToutRapport.first;

  var dropAnnee = listAnnee.first;

  //le model des doneess necessaires pour cette page
  late AgenceVM myAgence;

  //valeur du dropDownButton pour les agences
  late String dropdownValueAgence = myAgence.items.map((e) => e.desinAge).first;

  //valeur du dropDownButton pour les sites
  late String dropdownValueSite =
      myAgence.itemsSite.map((e) => e.designsite).first;

  var siteController = TextEditingController();
  var designController = TextEditingController();

  var dateDebut = dateFormat.format(DateTime.now());

  var dateFin = dateFormat.format(DateTime.now());

  choixTriCompte? _character = choixTriCompte.numero;
  late var etatDate;

  Future<void> DateN(String dateLabel) async {
    DateTime? pickleDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (pickleDate != null) {
      setState(() {
        if (etatDate == "debut") {
          dateDebut = dateFormat.format(pickleDate);
        } else {
          dateFin = dateFormat.format(pickleDate);
        }
      });
    }
  }

  void changeSite() {}

  @override
  Widget build(BuildContext context) {
    myAgence = Provider.of<AgenceVM>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Aperçu des rapports comptables",
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Card(
          elevation: 2,
          color: Colors.grey[300],
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: (Column(
                  children: <Widget>[
                    const Divider(color: Color.fromARGB(255, 0, 129, 129)),
                    const Text(
                      "Type de rapport",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const Divider(color: Color.fromARGB(255, 0, 129, 129)),
                    DropdownButton<String>(
                        value: dropTypeRapValue,
                        icon: const Icon(Icons.arrow_drop_down_circle_sharp),
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
                            dropTypeRapValue = value!;
                            if (value == "Rapports d'enregeistrement") {
                              dropRapport = Rapport.RapportEnregistrement.first;
                              listToutRapport = Rapport.RapportEnregistrement;
                            } else if (value == "Rapport de classement") {
                              dropRapport = Rapport.RapportClassement.first;
                              listToutRapport = Rapport.RapportClassement;
                            } else if (value == "Rapport de verification") {
                              dropRapport = Rapport.RapportVerification.first;
                              listToutRapport = Rapport.RapportVerification;
                            } else if (value == "Rapport de synthese") {
                              dropRapport = Rapport.RapportSyntese.first;
                              listToutRapport = Rapport.RapportSyntese;
                            }
                          });
                        },
                        items: listTypeRap
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    DropdownButton<String>(
                        value: dropRapport,
                        icon: const Icon(Icons.arrow_drop_down_circle_sharp),
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
                            dropRapport = value!;
                          });
                        },
                        items: listToutRapport
                            .map<DropdownMenuItem<String>>((dynamic value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                    const SizedBox(height: 10),
                    const Divider(color: Color.fromARGB(255, 0, 129, 129)),
                    const Text(
                      "Parametres générals",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const Divider(color: Color.fromARGB(255, 0, 129, 129)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Exercice"),
                        const SizedBox(width: 50),
                        DropdownButton<String>(
                            value: dropAnnee,
                            icon:
                                const Icon(Icons.arrow_drop_down_circle_sharp),
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
                                dropAnnee = value!;
                              });
                            },
                            items: listAnnee
                                .map<DropdownMenuItem<String>>((dynamic value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList()),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Date debut"),
                        const SizedBox(width: 30),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 129, 129),
                              ),
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                dateDebut!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 129, 129),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              etatDate = "debut";
                              DateN(dateDebut);
                            },
                            icon: const Icon(
                              Icons.date_range_rounded,
                              color: Color.fromARGB(255, 0, 129, 129),
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Date fin"),
                        const SizedBox(width: 50),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 129, 129),
                              ),
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                dateFin!,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 129, 129),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                            onPressed: () {
                              etatDate = "fin";
                              DateN(dateFin);
                            },
                            icon: const Icon(Icons.date_range_rounded,
                                color: Color.fromARGB(255, 0, 129, 129))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Agence"),
                        const SizedBox(width: 50),
                        DropdownButton<String>(
                            value: dropdownValueAgence,
                            icon:
                                const Icon(Icons.arrow_drop_down_circle_sharp),
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
                                .map((e) => DropdownMenuItem(
                                      value: e.desinAge,
                                      child: Text(e.desinAge),
                                    ))
                                .toList())
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Site"),
                        const SizedBox(width: 75),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    const Divider(color: Color.fromARGB(255, 0, 129, 129)),
                    const Text(
                      "Paramètres du compte",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    const Divider(color: Color.fromARGB(255, 0, 129, 129)),
                    const SizedBox(height: 10),
                    ListTile(
                      title: const Text('Numéro'),
                      leading: Radio<choixTriCompte>(
                        activeColor: const Color.fromARGB(255, 0, 129, 129),
                        value: choixTriCompte.numero,
                        groupValue: _character,
                        onChanged: (choixTriCompte? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Intitulé'),
                      leading: Radio<choixTriCompte>(
                        activeColor: const Color.fromARGB(255, 0, 129, 129),
                        value: choixTriCompte.intitule,
                        groupValue: _character,
                        onChanged: (choixTriCompte? value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          "Rech",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 75),
                        Container(
                          height: 40,
                          width: 220,
                          decoration: BoxDecoration(
                              color: Colors.white60,
                              border: Border.all(
                                color: const Color.fromARGB(255, 0, 129, 129),
                              ),
                              borderRadius: BorderRadius.circular(3)),
                          child: const Center(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: TextField(),),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const myHeaderDrawer(),
              myBodyDrawer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ListAgencePage()));
        },
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
        child: const Icon(Icons.remove_red_eye_outlined),
      ),
    );
  }

  Widget myBodyDrawer() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          myDrawItem(1, "Acceuil", Icons.home, true),
          myDrawItem(2, "Aperçu avant impression", Icons.print, true),
          myDrawItem(3, "Quitter", Icons.exit_to_app_rounded, true),
        ],
      ),
    );
  }

  Widget myDrawItem(int id, String itemText, IconData icon, bool selected) {
    return Material(
        color: Colors.grey,
        child: InkWell(
          onTap: () {
            Navigator.of(context);

            //set the main
            setState(() {
              if (id == 1) {
              } else if (id == 2) {}
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Color.fromARGB(255, 0, 129, 129),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    itemText,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

enum DrawerSection { Acceui, Apercu, Quitter }
