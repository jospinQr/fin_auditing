import 'package:animate_do/animate_do.dart';
import 'package:fin_auditing/Public/Views/Components/MyButton.dart';
import 'package:fin_auditing/Public/Views/Pages/SplashView.dart';
import 'package:flutter/material.dart';





class connectionFail extends StatefulWidget {
  const connectionFail({super.key});

  @override
  State<connectionFail> createState() => _connectionFailState();
}

class _connectionFailState extends State<connectionFail> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Center(
          child: BounceInDown(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/A8.jpg"),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: ElevatedButton.icon(

                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashView(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Resayer"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        backgroundColor:
                        const Color.fromARGB(255, 0, 129, 129)),
                  ),
                ),
                const SizedBox(height: 100,),
                const Text("La connection au serveur a echoué",style:TextStyle(color:Colors.red),),
              ],
            )),
          ),
        ),

    );
  }
}
