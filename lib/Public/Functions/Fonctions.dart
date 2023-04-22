import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Fonctions {
  //AlertDialog
  static void MessageDialog(
      String titre, String Contenu, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white60,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.stacked_line_chart),
            ),
          ],
          title: Text(titre),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 0, 129, 129),
            fontWeight: FontWeight.bold

          ),

          content: Text(Contenu),
          contentTextStyle: TextStyle(fontWeight: FontWeight.w300,color: Colors.black),
          scrollable: true,
          shape: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 0, 129, 129), width: 2),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        );
      },
    );
  }

  //verifier la connectivité au reseaux

  static late bool estConnecter;

  Future<void> CheckUserConnection() async {
    try {
      var response = await http.get(Uri.parse("http://192.168.43.163:8000/"));

      if (response.statusCode == 200) {
        estConnecter = true;
      } else {
        estConnecter = false;
      }
    } on SocketException catch (e) {
      estConnecter = false;
      log(e.message);
    }
  }
}
