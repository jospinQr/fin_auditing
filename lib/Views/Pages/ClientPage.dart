import 'package:fin_auditing/ViewModel/ApiServices/ClientApi.dart';
import 'package:fin_auditing/Models/ClientM.dart';
import 'package:fin_auditing/Views/Pages/DetailClientPage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late List<ClientM>? _client = [];

  void _getClient(String packageName) async {
    _client = (await ClientApi().getClient(packageName));
    Future.delayed(const Duration(milliseconds: 800))
        .then((value) => setState(() {}));
  }

  @override
  void initState() {
    _getClient("http");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 129, 129),
          title: const Text("List des clients"),
          actions: <Widget>[
            IconButton(onPressed:(){

            }, icon: Icon(Icons.search_rounded),)
          ],
        ),
        body: _client == null || _client!.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
          itemCount: _client!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text(_client![index].nomcli[0]),),
              title: Text(_client![index].nomcli),
              subtitle: Text(_client![index].numtelcli),
              onTap: () =>
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailClientPage(
                          client: _client![index],
                        ),
                  ),
                )
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              height: 1,
              color: Color.fromARGB(255, 0, 129, 129),
            );
          },
        ),
      ),
    );
  }


}




