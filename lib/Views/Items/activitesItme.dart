import 'package:flutter/material.dart';

class activitesItem extends StatelessWidget {
  final String name;
  final Function() onPress;
  final String asset;
  const activitesItem(
      {super.key,
      required this.name,
      required this.asset,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9), color: Colors.white),
      child: Column(
        children: [
          Image(
            image: AssetImage(asset),
            height: 80,
            width: 100,
          ),
          Text(name),
          ElevatedButton(
            onPressed: () => onPress(),
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 0, 129, 129),
            ),
            child: const Text("Connexion"),
          )
        ],
      ),
    );
  }
}
