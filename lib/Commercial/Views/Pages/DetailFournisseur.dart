import 'package:fin_auditing/Commercial/Models/FournisseurM.dart';
import 'package:flutter/material.dart';
import '../../Models/ClientM.dart';

class DetailFounisseurPage extends StatelessWidget {
  final FournisseurM fournisseur;

  const DetailFounisseurPage({Key? key, required this.fournisseur}) : super(key: key);

  void _sendSms(String message,String num) async{

    try{
      // await sendSMS(message: message, recipients: recipients);

    }catch(error){
      print(error.toString());

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${fournisseur.nomFourni} "),
        backgroundColor: const Color.fromARGB(255, 0, 129, 129),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(
                    color: Color.fromARGB(255, 0, 129, 129),
                    height: 34,
                    thickness: 02,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Fournisseur numero :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(fournisseur.numFourni)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Nom :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(fournisseur.nomFourni)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Ville:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(fournisseur.villeFourni)
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Téléphone :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(fournisseur.numtelFourni)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Email :",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(fournisseur.emailFourni)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Color.fromARGB(255, 0, 129, 129),
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Color.fromARGB(255, 0, 129, 129),
                      ),
                      Icon(
                        Icons.star_border,
                        size: 20,
                        color: Color.fromARGB(255, 0, 129, 129),
                      ),
                      Icon(
                        Icons.star_border,
                        size: 20,
                        color: Color.fromARGB(255, 0, 129, 129),
                      ),
                      Icon(
                        Icons.star_border,
                        size: 20,
                        color: Color.fromARGB(255, 0, 129, 129),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 0, 129, 129),
                    height: 34,
                    thickness: 02,
                  ),
                  const Text(
                    "Notifier le client de sa situation via :",
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 129, 129),
                        fontStyle: FontStyle.italic),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            _sendSms("Bonjour votre sodle hoajue est de: ",fournisseur.numtelFourni);
                          },
                          icon: const Icon(Icons.sms_failed_rounded),
                          label: const Text('SMS'),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor:
                              const Color.fromARGB(255, 0, 129, 129)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("-----ou----"),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.alternate_email_sharp),
                          label: const Text('Email'),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
                              backgroundColor:
                              const Color.fromARGB(255, 0, 129, 129)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );

  }


}
