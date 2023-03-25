import 'package:fin_auditing/ModelView/Journal/AgenceJVM.dart';
import 'package:fin_auditing/ModelView/Journal/SiteJVM.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ModelView/AgenceVM.dart';

class ListSitePage extends StatelessWidget {
   ListSitePage({Key? key,required this.agence}) : super(key: key);

 String agence;

  @override
  Widget build(BuildContext context) {
    SiteJVM _site = Provider.of<SiteJVM>(context);

    if (_site.items.isEmpty) {
      _site.loadSiteItems("A01");
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.cyanAccent,
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choississez un site"),
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
      ),
      body:  ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_site.items[index].codsite.toString()),
            subtitle: Text(_site.items[index].designsite.toString()),
            onTap: () {

            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 1,
            color: Color.fromARGB(255, 0, 129, 129),
          );
        },
        itemCount: _site.items.length,

      ),
    );
  }
}
