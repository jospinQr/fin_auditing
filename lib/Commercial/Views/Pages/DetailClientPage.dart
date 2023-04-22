import 'package:flutter/material.dart';
import '../../Models/ClientM.dart';

class DetailClientPage extends StatelessWidget {
  final ClientM client;

  const DetailClientPage({Key? key, required this.client}) : super(key: key);

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
        title: Text("${client.nomcli}  Agence:  ${client.agence}"),
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
                    "Client numero :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(client.numcli)
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
                  Text(client.nomcli)
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
                  Text(client.villecli)
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
                  Text(client.numtelcli)
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
                  Text(client.emailcli)
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
                        _sendSms("Bonjour votre sodle hoajue est de: ",client.numtelcli);
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
