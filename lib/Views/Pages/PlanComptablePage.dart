import 'package:fin_auditing/ModelView/ApiServices/CompteApi.dart';
import 'package:fin_auditing/Models/CompteM.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlanComptablaPage extends StatefulWidget {
  const PlanComptablaPage({super.key});

  @override
  State<PlanComptablaPage> createState() => _PlanComptablaPageState();
}

class _PlanComptablaPageState extends State<PlanComptablaPage> {
  late List<Compte>? _comptes = [];

  void _getCompte(String packageName) async {
    _comptes = (await CompteApi().getComptes(packageName))!;
    Future.delayed(const Duration(milliseconds: 800))
        .then((value) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();

    _getCompte("http");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: const Text("Liste des comptes"),backgroundColor:const Color.fromARGB(255, 0, 129, 129), ),
      body: _comptes == null || _comptes!.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _comptes!.length,
              itemBuilder: (context, index) {
                return ListTile(

                     title: Text(_comptes![index].intitulecpte),
                     subtitle: Text(_comptes![index].numcpte),
                );
              }),
    );
  }
}
