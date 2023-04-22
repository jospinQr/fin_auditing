import 'package:flutter/material.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown(
      {Key? key,
      required this.valueDrop,
      required this.list,
      required this.onChanged})
      : super(key: key);

  final String valueDrop;
  final List<String> list;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 0, 129, 129),
          width: 1,

        ),
        borderRadius: BorderRadius.circular(5)

      ),
      child: DropdownButton<String>(
        value: valueDrop,
        icon: const Icon(Icons.arrow_drop_down_circle_sharp),
        elevation: 16,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 129, 129),
        ),
        onChanged: onChanged(),
        items: list.map<DropdownMenuItem<String>>((dynamic value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
