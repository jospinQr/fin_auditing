import 'dart:convert';
import 'dart:developer';

import 'package:fin_auditing/Constants/ApiConstants.dart';
import 'package:fin_auditing/Functions/Fonctions.dart';
import 'package:fin_auditing/Views/Components/MyButton.dart';
import 'package:fin_auditing/Views/Components/MyTextField.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fin_auditing/Functions/MyExpextion.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({Key? key}) : super(key: key);

  @override
  State<AddArticle> createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  final designation = TextEditingController();
  final pua = TextEditingController();
  final puv = TextEditingController();
  final qt = TextEditingController();
  final qtMin = TextEditingController();
  final codArt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.zero,
                alignment: Alignment.bottomCenter,
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MyTextField(
                        controller: designation,
                        hintText: 'Code article',
                        icontxt: Icons.add_box_rounded,
                        isPsw: false,
                        validator: null,
                      ),

                      MyTextField(
                        controller: designation,
                        hintText: 'Designation',
                        icontxt: Icons.add_box_rounded,
                        isPsw: false,
                        validator: null,
                      ),
                      MyTextField(
                        controller: pua,
                        hintText: 'Pua',
                        icontxt: null,
                        isPsw: false,
                        validator: null,
                      ),
                      MyTextField(
                        controller: puv,
                        hintText: 'puv',
                        icontxt: null,
                        isPsw: false,
                        validator: null,
                      ),
                      MyTextField(
                        controller: qt,
                        hintText: 'Quantite initiale',
                        icontxt: null,
                        isPsw: false,
                        validator: null,
                      ),
                      MyTextField(
                        controller: qtMin,
                        hintText: 'Quantite initiale',
                        icontxt: null,
                        isPsw: false,
                        validator: null,
                      ),
                      MyBoutton(
                          text: "Enregistrer", onTap: () => {_save("http")})
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save(String packageName) async {
    Map<String, dynamic> article = {
      'codeArticle': codArt.text,
      'designArticle': designation.text,
      'qtArticle': qt.text,
      'pua': pua.text,
      'puv': puv.text,
      'qtMinStock': qtMin.text,
    };

    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.articleEndPoint);
    final response = await http.post(url, body: article,encoding: Encoding.getByName("UTF-8"));

    if (response.statusCode != 200) {
      log(response.statusCode.toString() + url.toString());
      throw PackageRecupererException(
          packageName: packageName, statusCode: response.statusCode);
    }

    Fonctions.MessageDialog('Message', 'Enregistrement', context);
  }
}
