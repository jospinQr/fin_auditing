import 'dart:developer';
import 'dart:io';
import 'package:fin_auditing/Views/Pages/LoginPage.dart';
import 'package:fin_auditing/Views/Pages/ConnectionFaildPage.dart';
import 'package:flutter/material.dart';
import 'package:fin_auditing/ModelView/ApiServices/ApiConstants.dart';
import 'package:http/http.dart'as http;
import 'package:splashscreen/splashscreen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  //ici  on verifie si notre applicqtion est connect a notre serveur
  bool estConnecter=false;
  Future<void> CheckUserConnection() async {

    try{
       var response=await http.get(Uri.parse(ApiConstants.severUrl));

       if(response.statusCode==200) {
         setState(() {
              estConnecter=true;
          });
       }else{
         setState(() {
            estConnecter=false;
         });
       }
    }on SocketException catch(e){
           estConnecter=false;
           log(e.message)  ; 
    }
       
      
  }
 
  @override
  void initState() {
     CheckUserConnection();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      backgroundColor: Colors.grey[100],
      image: Image.asset(
        "assets/logo.png",
        color: const Color.fromARGB(255, 0, 129, 129),
        width: 5100,
        height: 2200,
      ),
      loaderColor: const Color.fromARGB(255, 0, 129, 129),
      loadingText: const Text(
        "Chargement...",
        style: TextStyle(
          color: Color.fromARGB(255, 0, 129, 129),
        ),
      ),
      navigateAfterSeconds:estConnecter==true ?  LoginPage():const connectionFail(),
      useLoader: true,
      photoSize: 100,
      title: const Text(
        "by SpeedSoftIt",
      ),

    );
  }
}
