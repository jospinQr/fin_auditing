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
          title: Text(titre),
          content: Text(Contenu),
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
