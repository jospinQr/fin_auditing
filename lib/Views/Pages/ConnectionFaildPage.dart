import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Views/Pages/SplashView.dart';
import 'package:flutter/material.dart';

import '../Components/MyButton.dart';

class connectionFail extends StatefulWidget {
  const connectionFail({super.key});

  @override
  State<connectionFail> createState() => _connectionFailState();
}

class _connectionFailState extends State<connectionFail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        body: Center(
          child: BounceInDown(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.signal_wifi_statusbar_connected_no_internet_4_sharp,
                  size: 150,
                  color: Color.fromARGB(255, 168, 3, 3),
                ),
                const Text(
                  "OUPS! vous n'etes pas connecter",
                  style: TextStyle(
                    color: Color.fromARGB(255, 168, 3, 3),
                  ),
                ),
                MyBoutton(
                    text: "Resayer", onTap: () => {_openSplash(), dispose()}),
              ],
            )),
          ),
        ),
      ),
    );
  }

  void _openSplash() {
    Navigator.push(context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const SplashView(),

      ),
    );
  }
}
