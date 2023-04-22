import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyBoutton extends StatelessWidget {
  const MyBoutton({super.key, required this.text, required this.onTap});

  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    
        onTap: onTap,
        child: Container(
          
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 129, 129),
              borderRadius: BorderRadius.circular(10)),

          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ));
  }
}
