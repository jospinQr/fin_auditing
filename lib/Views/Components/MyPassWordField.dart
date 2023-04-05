import 'package:flutter/material.dart';

class MyPassWordField extends StatefulWidget {
  const MyPassWordField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.helpText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final controller;
  final String? hintText;
  final String? labelText;
  final String? helpText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<MyPassWordField> createState() => _MyPassWordFieldState();
}

class _MyPassWordFieldState extends State<MyPassWordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        onSaved: widget.onSaved,
        validator: widget.validator,
        maxLength: 8,
        decoration: InputDecoration(
          icon: const Icon(
            Icons.lock,
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
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 129, 129)),
          hintStyle: const TextStyle(color: Colors.black45),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(
              _obscureText
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              color: const Color.fromARGB(255, 0, 129, 129),
            ),
          ),
        ),
      ),
    );
  }
}
