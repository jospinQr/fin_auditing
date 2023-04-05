import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Views/Pages/JounalPages/ListeSitePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ViewModel/Journal/AgenceJVM.dart';
import '../LoadingPage.dart';

class ListAgencePage extends StatefulWidget {
  const ListAgencePage({Key? key}) : super(key: key);

  @override
  State<ListAgencePage> createState() => _ListAgencePageState();
}

class _ListAgencePageState extends State<ListAgencePage> {
  @override
  Widget build(BuildContext context) {
    AgenceJVM _agence = Provider.of<AgenceJVM>(context);

    return FutureBuilder(
        future: _agence.loadAgenceItems(),
        builder: (context, snapshot) {
          if(_agence.items.isEmpty){
            _agence.loadAgenceItems();
            return const LoadingPage();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Choisissez un agence"),
              backgroundColor: Color.fromARGB(255, 0, 129, 129),
            ),
            body: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_agence.items[index].codAge.toString()),
                  subtitle: Text(_agence.items[index].desinAge.toString()),
                  onTap: () {
                    _agence.setAge(_agence.items[index].codAge.toString());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListSitePage(
                          agence: _agence.getCodeAgence,
                        ),
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
              itemCount: _agence.items.length,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => _builBottomSheet(context),
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

Container _builBottomSheet(BuildContext context) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Débit",
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              BounceInLeft(
                child: const Text('1000',
                    style: TextStyle(
                      color: Colors.white60,
                    )),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Crédit",
                style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              BounceInRight(
                child: const Text(
                  '1000',
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}
