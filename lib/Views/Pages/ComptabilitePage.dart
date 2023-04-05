import 'package:fin_auditing/ViewModel/TypeRapportVM.dart';
import 'package:fin_auditing/Views/Drawer/myHeaderDrawer.dart';
import 'package:fin_auditing/Views/Pages/JounalPages/ListAgencePage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fin_auditing/Models/RapportM.dart';
import '../../ViewModel/AgenceVM.dart';
import '../../Functions/Fonctions.dart';
import 'package:intl/intl.dart';

import '../../ViewModel/Journal/ExerciceVM.dart';

class ComptabilitePage extends StatefulWidget {
  const ComptabilitePage({Key? key}) : super(key: key);

  @override
  State<ComptabilitePage> createState() => _ComptabilitePageState();
}

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

var listTypeRap = Rapport.typeRapport;
var listRapport = Rapport.RapportEnregistrement;

List<String> listAnnee = <String>['2021', '2020'];

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

  @override
  Widget build(BuildContext context) {
    myAgence = Provider.of<AgenceVM>(context);
    var annee = Provider.of<ExerciceVM>(context);
    var typeRapport = Provider.of<TypeRapportVM>(context);
    annee.setanne(dropAnnee);
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [

              Card(
                  margin: EdgeInsets.all(20),
                  elevation: 2,
                  borderOnForeground: true,
                  color: Colors.grey[300],


                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                                    dropTypeRapValue = value!;
                                    if (value == "Rapports d'enregeistrement") {
                                      dropRapport =
                                          Rapport.RapportEnregistrement.first;
                                      listToutRapport =
                                          Rapport.RapportEnregistrement;
                                    } else if (value == "Rapport de classement") {
                                      dropRapport = Rapport.RapportClassement.first;
                                      listToutRapport = Rapport.RapportClassement;
                                    } else if (value == "Rapport de verification") {
                                      dropRapport =
                                          Rapport.RapportVerification.first;
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
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Rapport",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                                value: dropRapport,
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
                                  typeRapport.setRapportName(value!);
                                  if (value == "Journal Brouillard") {
                                    typeRapport.setObservation("0");
                                  } else if (value == "Journal Chronologique") {
                                    typeRapport.setObservation("1");
                                  }
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
                                    annee.setanne(value!);
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Rech",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                                  child: TextField(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  )),
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
          switch (dropRapport) {
            case "Journal Chronologique":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListAgencePage()));
              break;

            case "Journal Brouillard":
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListAgencePage()));
              break;
            case "Grand-Livre de l'Actif":
              Fonctions.MessageDialog("", "Ok", context);
              break;
            default:
              Fonctions.MessageDialog("", dropRapport, context);
          }
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
