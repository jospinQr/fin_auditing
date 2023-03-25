import 'package:fin_auditing/Views/Pages/JounalPages/ListeSitePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ModelView/Journal/AgenceJVM.dart';

class ListAgencePage extends StatelessWidget {
  const ListAgencePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AgenceJVM _agence = Provider.of<AgenceJVM>(context);
    if (_agence.items.isEmpty) {
      _agence.loadAgenceItems();
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
          title: Text("Choisissez un agence"),
          backgroundColor: Color.fromARGB(255, 0, 129, 129),
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_agence.items[index].codAge.toString()),
              subtitle: Text(_agence.items[index].desinAge.toString()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListSitePage(
                      agence: _agence.items[index].codAge.toString(),
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

    );
  }
}
