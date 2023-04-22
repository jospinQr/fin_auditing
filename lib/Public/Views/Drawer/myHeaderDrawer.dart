import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class myHeaderDrawer extends StatefulWidget {
  const myHeaderDrawer({super.key});

  @override
  State<myHeaderDrawer> createState() => _myHeaderDrawerState();
}

class _myHeaderDrawerState extends State<myHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 129, 129),
      width: double.infinity,
      height: 180.0,
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: const [
                Image(
                  image: AssetImage('assets/logo.png'),
                ),
                SizedBox(height: 4,),
                Text("By SpeedS@ft IT",style: TextStyle(color:Color.fromARGB(255, 240, 245, 245) ),)
              ], 
            ),
          ),
        ],
      ),
    );
  }
}
