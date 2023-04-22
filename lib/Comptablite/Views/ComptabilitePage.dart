import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../Public/ViewModel/AgenceVM.dart';
import '../../Public/Views/Drawer/myHeaderDrawer.dart';
import '../../Public/Views/Pages/LoadingPage.dart';
import '../Constants/RapportM.dart';
import '../../Public/ViewModel/ExerciceVM.dart';
import '../ViewModel/TypeRapportVM.dart';
import 'Pages/BilanPage/ListAgencePage.dart';
import 'Pages/GrandLivre/ComptePage.dart';
import 'Pages/JounalPages/ListAgencePage.dart';

class ComptabilitePage extends StatefulWidget {
  const ComptabilitePage({Key? key}) : super(key: key);

  @override
  State<ComptabilitePage> createState() => _ComptabilitePageState();
}

final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

var listTypeRap = Rapport.typeRapport;
var listRapport = Rapport.RapportEnregistrement;

enum choixTriCompte { numero, intitule }

class _ComptabilitePageState extends State<ComptabilitePage> {
  var currentDrawer = DrawerSection.Apercu;
  late List listToutRapport = listRapport;
  var dropTypeRapValue = listTypeRap.first;
  late String dropRapport = listToutRapport.first;

  //le model des doneess necessaires pour cette page
  late AgenceVM myAgence;
  late ExerciceVM exercice;

  //valeur du dropDownButton pour les agences
  late String dropdownValueAgence = myAgence.items.map((e) => e.desinAge).first;

  //valeur du dropDownButton pour les sites
  late String dropdownValueSite = exercice.items.map((e) => e.annee).first;

//valeur du dropDownButton pour les exercice
  late String dropdownValueExec = exercice.items.map((e) => e.annee).first;
  var siteController = TextEditingController();
  var designController = TextEditingController();

  var dateDebut = dateFormat.format(DateTime.now());

  var dateFin = dateFormat.format(DateTime.now());

  choixTriCompte? _character = choixTriCompte.numero;
  late var etatDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    myAgence = Provider.of<AgenceVM>(context);
    exercice = Provider.of<ExerciceVM>(context);
    var typeRapport = Provider.of<TypeRapportVM>(context);

    if (exercice.items.isEmpty) {
      exercice.loadListeExercice();
      return const LoadingPage();
    }
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
                  margin: const EdgeInsets.all(20),
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
                                    dropTypeRapValue = value!;
                                    if (value == "Rapports d'enregeistrement") {
                                      dropRapport =
                                          Rapport.RapportEnregistrement.first;
                                      listToutRapport =
                                          Rapport.RapportEnregistrement;
                                    } else if (value ==
                                        "Rapport de classement") {
                                      dropRapport =
                                          Rapport.RapportClassement.first;
                                      listToutRapport =
                                          Rapport.RapportClassement;
                                    } else if (value ==
                                        "Rapport de verification") {
                                      dropRapport =
                                          Rapport.RapportVerification.first;
                                      listToutRapport =
                                          Rapport.RapportVerification;
                                    } else if (value == "Rapport de synthese") {
                                      dropRapport =
                                          Rapport.RapportSyntese.first;
                                      listToutRapport = Rapport.RapportSyntese;
                                    }
                                  });
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Rapport",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            DropdownButton<String>(
                                value: dropRapport,
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
                                  typeRapport.setRapportName(value!);

                                  switch (value) {
                                    case "Journal Brouillard":
                                      typeRapport.setObservation("0");
                                      typeRapport
                                          .setRapportName("Journal Brouillard");
                                      break;
                                    case "Journal Chronologique":
                                      typeRapport.setObservation("1");
                                      typeRapport.setRapportName(
                                          "Journal Chronologique");
                                      break;
                                    case "Journal des Initiales":
                                      typeRapport.setObservation("1");
                                      typeRapport
                                          .setTypeJournal('Initialisation');
                                      typeRapport.setRapportName(
                                          "Journal des Initiales");
                                      break;
                                    case "Journal des Achats":
                                      typeRapport.setObservation("1");
                                      typeRapport.setTypeJournal('Achat');
                                      typeRapport
                                          .setRapportName("Journal des Achats");
                                      break;

                                    case "Journal des Ventes":
                                      typeRapport.setObservation("1");
                                      typeRapport.setTypeJournal('Vente');
                                      typeRapport
                                          .setRapportName('Journal des Ventes');
                                      break;

                                    case "Journal d'Encaissement":
                                      typeRapport.setObservation("1");
                                      typeRapport
                                          .setTypeJournal('Encaissement');
                                      typeRapport.setRapportName(
                                          "Journal d'Encaissement");
                                      break;
                                    case "Journal de Décaissement":
                                      typeRapport.setObservation("1");
                                      typeRapport
                                          .setTypeJournal('Decaissement');

                                      typeRapport.setRapportName(
                                          "Journal de Décaissement");
                                      break;
                                    case "Journal de Stockage":
                                      typeRapport.setObservation("1");
                                      typeRapport.setTypeJournal('Stockage');
                                      typeRapport.setRapportName(
                                          'Journal de Stockage');

                                      break;

                                    case "Journal de Déstockage":
                                      typeRapport.setObservation("1");
                                      typeRapport.setTypeJournal('Destockage');
                                      typeRapport.setRapportName(
                                          'Journal de Déstockage');
                                      break;

                                    case "Journal des Régularisations":
                                      typeRapport.setObservation("1");
                                      typeRapport
                                          .setTypeJournal('Regularisation');
                                      typeRapport.setRapportName(
                                          'Journal des Régularisations');

                                      break;
                                    case "Journal des Etalements":
                                      typeRapport.setObservation("1");
                                      typeRapport.setTypeJournal('Etalement');
                                      typeRapport.setRapportName(
                                          'Journal des Etalements');
                                      break;

                                    case "Journal des Amortissements":
                                      typeRapport.setObservation("1");
                                      typeRapport
                                          .setTypeJournal("Amortissement");
                                      typeRapport.setRapportName(
                                          "Journal des Amortissements");
                                      break;

                                    case "Journal des Provisionnements":
                                      typeRapport.setObservation("1");
                                      typeRapport.setTypeJournal("Provision");
                                      typeRapport.setRapportName(
                                          "Journal des Provisionnements");
                                      break;
                                    case "Journal des Affections":
                                      typeRapport.setObservation("1");
                                      typeRapport.setTypeJournal("Affectation");
                                      typeRapport.setRapportName(
                                          "Journal des Affections");
                                      break;
                                    case "Bilan Général":
                                      typeRapport
                                          .setRapportName("Bilan general");
                                      break;
                                    case "Grand-Livre du Patrimoine":
                                      typeRapport.setRapportName("Patrimoine");
                                      break;
                                    case "Grand-Livre de l'Actif":
                                      typeRapport.setRapportName("ACTIF");
                                      break;
                                    case "Grand-Livre du Passif":
                                      typeRapport.setRapportName("PASSIF");
                                      break;
                                    case "Grand-Livre des Produits":
                                      typeRapport.setRapportName("PRODUIT");
                                      break;
                                    case "Grand-Livre des Charge":
                                      typeRapport.setRapportName("CHARGE");

                                      break;
                                    case "Grand-Livre de l'Exploitation":
                                      typeRapport
                                          .setRapportName("Exploitation");
                                      break;
                                    case "Grand-Livre Général":
                                      typeRapport
                                          .setRapportName("GrdL General");

                                      break;
                                  }

                                  setState(() {
                                    dropRapport = value;
                                  });
                                },
                                items: listToutRapport
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
                                    exercice.setanne(value!);
                                    dropdownValueExec = value;
                                  });
                                },
                                items: exercice.items
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.annee,
                                        child: Text(e.annee),
                                      ),
                                    )
                                    .toList()),
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
                                    color:
                                        const Color.fromARGB(255, 0, 129, 129),
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
          exercice.setanne(dropdownValueExec);
          String rapportName = typeRapport.getRapportName;
          if (rapportName == "Journal Brouillard" ||
              rapportName == "Journal Chronologique" ||
              rapportName == "Journal des Initiales" ||
              rapportName == "Journal des Achats" ||
              rapportName == "Journal des Ventes" ||
              rapportName == "Journal d'Encaissement" ||
              rapportName == "Journal de Décaissement" ||
              rapportName == "Journal de Stockage" ||
              rapportName == "Journal des Régularisations" ||
              rapportName == "Journal des Etalements" ||
              rapportName == "Journal des Provisionnements" ||
              rapportName == "Journal des Amortissements" ||
              rapportName == "Journal des Affections") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListAgencePage()));
          } else if (typeRapport.getRapportName == "Bilan general") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListAgenceBilanPage()));
          } else if (typeRapport.getRapportName == "Patrimoine" ||
              typeRapport.getRapportName == "Exploitation" ||
              typeRapport.getRapportName == "ACTIF" ||
              typeRapport.getRapportName == "PASSIF" ||
              typeRapport.getRapportName == "CHARGE" ||
              typeRapport.getRapportName == "PRODUIT") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ComptePage()));
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
