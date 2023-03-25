import 'dart:convert';
import 'package:fin_auditing/ModelView/ApiServices/UserApi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../../Models/User.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  late Future<User> user;

  @override
  void initState() {
    super.initState();
    user = UserApi().getUser("http");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data!.userName),
            );
          }
          else{
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return  CircularProgressIndicator();
        },
      ),
    );
  }
}
