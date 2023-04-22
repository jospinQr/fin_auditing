import 'dart:convert';
import 'dart:developer';
import 'package:fin_auditing/Public/Constants/ApiConatants.dart' as publicConst;
import 'package:fin_auditing/Commercial/Constants/ApiConstants.dart'
    as comConst;
import 'package:fin_auditing/Commercial/Models/StockAlertM.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../Public/Functions/MyExpextion.dart';
import '../../../Public/ViewModel/SiteVM.dart';
import '../../../Public/Views/Pages/LoadingPage.dart';

class StockAlertPage extends StatefulWidget {
  const StockAlertPage({Key? key, required this.codSite}) : super(key: key);
  final String codSite;

  @override
  State<StockAlertPage> createState() => _StockAlertPageState();
}

class _StockAlertPageState extends State<StockAlertPage> {
  List<StockAlertM> parse(String responseBody) => List<StockAlertM>.from(
      jsonDecode(responseBody).map((x) => StockAlertM.fromjson(x)));

  Future<List<StockAlertM>?> fetchStockAlert(String packageName) async {
    final url = Uri.parse(
        "${publicConst.AipConstants.baseUrl}${comConst.ApiConstants.stockAlerUrlEndPoint}codsite=${widget.codSite}");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      log(response.statusCode.toString());
      throw PackageRecupererException(packageName: packageName);
    }

    List<StockAlertM> stockAlert = parse(response.body);

    return stockAlert;
  }

  @override
  Widget build(BuildContext context) {

    var site =Provider.of<SiteVM>(context);
    return FutureBuilder(
        future: fetchStockAlert("http"),
        builder: (context, AsyncSnapshot<List<StockAlertM>?> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingPage();
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 0, 129, 129),
              title:Text("Stock d'alert site ${site.getCodeSite}"),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DataTable(
                        sortAscending: true,
                        headingRowColor: MaterialStateColor.resolveWith(
                            (states) => const Color.fromARGB(255, 0, 129, 129)),
                        columns: const [
                          DataColumn(
                              label: Text("No Article",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("Designation",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("Unit.Ppl",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("SousUnit1",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("SousUnit2",
                                  style: TextStyle(color: Colors.white70))),
                          DataColumn(
                              label: Text("SousUnit3",
                                  style: TextStyle(color: Colors.white70)))
                        ],
                        rows: snapshot.data!
                            .map((e) => DataRow(cells: [
                                  DataCell(Text(e.numart)),
                                  DataCell(Text(e.designart)),
                                  DataCell(Text(e.unitppal)),
                                  DataCell(Text(e.sunit1)),
                                  DataCell(Text(e.sunit2)),
                                  DataCell(Text(e.sunit3)),
                                ]))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
