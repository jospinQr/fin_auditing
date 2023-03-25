import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool isPsw ;
  final icontxt;
  var validator;

   MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.icontxt,
      required this.isPsw,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPsw,
        validator: validator,
        decoration: InputDecoration(
            icon: Icon(
              icontxt,
              color: Color.fromARGB(255, 0, 129, 129),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 0, 129, 129)),
            ),
            fillColor: Colors.grey[100],
            filled: true,
            labelText: hintText,
            labelStyle: TextStyle(color: Color.fromARGB(255, 0, 129, 129)),
            hintStyle: const TextStyle(color: Colors.black45)),
      ),
    );
  }
}
