import 'dart:ffi';

import 'package:fin_auditing/Views/Components/MyIconMenu.dart';
import 'package:fin_auditing/Views/Drawer/myHeaderDrawer.dart';
import 'package:fin_auditing/Views/Pages/HomePage.dart';
import 'package:fin_auditing/Views/Pages/ArticlePage.dart';
import 'package:fin_auditing/Views/Pages/ProfilView.dart';
import 'package:flutter/material.dart';
import 'package:fin_auditing/Views/Pages/LoginPage.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  var currentDrawer = DrawerSection.main;
  int _currentIndex = 0;
  var fragments = [
    const HomePage(),
    const ArticlePage(),
    const ProfilView(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:const Text("FIN-AUDITING"),
          backgroundColor: const Color.fromARGB(255, 43, 41, 41),
          actions: [
            IconButton(
              icon:const Icon(
                Icons.lock,
                color: Color.fromARGB(255, 0, 129, 129),
              ),
              onPressed: () {},
            ),
            IconButton(
              icon:const Icon(
                Icons.output_rounded,
                color: Color.fromARGB(255, 0, 129, 129),
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Center(child: fragments[_currentIndex]),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 05,
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: const Color.fromARGB(255, 0, 129, 129),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 30,
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
                label: 'Recherche'),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: 'Moi',
            ),
          ],
        ),
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const myHeaderDrawer(),
                myBodyDrawer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myBodyDrawer() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          myDrawItem(1, "Connexion", Icons.login, true),
          myDrawItem(2, "Paramètres", Icons.settings, true),
          myDrawItem(3, "A propos", Icons.confirmation_num_outlined, true),
          myDrawItem(4, "Deconnection", Icons.logout, true),
        ],
      ),
    );
  }

  Widget myDrawItem(int id, String itemText, IconData icon, bool selected) {
    return Material(
        child: InkWell(
      onTap: () {
        Navigator.of(context);

        //set the main
        setState(() {
          if (id == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),

              ),
              
            );
          
          } else if (id == 2) {
            currentDrawer = DrawerSection.deconnection;
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                icon,
                size: 20,
                color: Color.fromARGB(255, 0, 129, 129),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                itemText,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

enum DrawerSection {
  main,
  connection,
  deconnection,
  apropos,
}
