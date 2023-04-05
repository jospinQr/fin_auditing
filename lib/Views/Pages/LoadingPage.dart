import 'package:flutter/material.dart';
class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Chargement en cours..."),
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
      ),
      body: const Center(
        child:  RefreshProgressIndicator(
          color: Color.fromARGB(255, 0, 129, 129),
          strokeWidth:5 ,
        ),
      ),
    );
  }
}
