import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:fin_auditing/ModelView/ApiServices/ApiConstants.dart';
import 'package:fin_auditing/Functions/Fonctions.dart';
import 'package:fin_auditing/Views/Components/myButton.dart';
import 'package:fin_auditing/Views/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import '../Components/MyTextField.dart';
import 'package:http/http.dart' as http;
import 'package:animate_do/animate_do.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

//Editingcontrollers pour recuperer les donnees forni par l'utilisateur
  final userName = TextEditingController();
  final psw = TextEditingController();

  bool isLoad = false;

//methode pour se logger au serveur
  Future<void> login(dynamic context) async {
    try {
      if (psw.text != "" && userName.text != "") {
        //une carte des informations du login
        Map<String, String> creditials = {
          "nomut": userName.text,
          "motdepassut": psw.text,
        };

        //la response au post de l'utilisateur
        final response = await http.post(
            Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndPoint),
            body: creditials);
        if (response.statusCode == 200) {
          // si les info du user sont correctes on ouvre la page d'acceuil
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );

        } else {
          Fonctions.MessageDialog(
              "Echec",
              "Mot de passe ou nom d'utilisateur incorect${response.statusCode}",
              context);
        }
      } else {
        Fonctions.MessageDialog(
            "Attention", "Veillez completer tous les champs", context);
      }
    } on TimeoutException {
      Fonctions.MessageDialog("Attention", "timeOute", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        // child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BounceInDown(
                child: Image.asset(
                  "assets/logo.png",
                  color: const Color.fromARGB(255, 0, 129, 129),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Column(
                  children: [
                    Spin(
                        child: const Icon(
                      Icons.lock,
                      size: 70,
                      color: Color.fromARGB(255, 0, 129, 129),
                    )),
                    const SizedBox(height: 5),
                    Text(
                      "Login Form",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.normal,
                          fontFamily: 'LUCIDA CALLIGRAPHY'),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      child: Column(
                        children: [
                          MyTextField(
                            controller: userName,
                            hintText: "Nom d'utilisateur",
                            icontxt: Icons.person,
                            isPsw: false,
                            validator: null,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MyTextField(
                            controller: psw,
                            icontxt: Icons.lock,
                            hintText: "Mot de passe",
                            isPsw: true,
                            validator: null,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MyBoutton(
                            text: 'Connexion',
                            onTap: () => {login(context)},
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: isLoad,
                      child: const CircularProgressIndicator(
                        color: Color.fromARGB(255, 0, 129, 129),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
