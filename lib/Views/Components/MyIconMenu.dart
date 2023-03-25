import 'package:flutter/material.dart';

class MyIconMenu extends StatelessWidget {
  const MyIconMenu({Key? key, required this.icon, required this.onclick})
      : super(key: key);

  final IconData icon;
  final Function()? onclick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onclick,
      child: Container(
          height: 1,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 0, 129, 129),
          ),

          child: Icon(
            icon,
            color: Colors.grey,
          )),
    );
  }
}
