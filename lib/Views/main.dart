import 'package:fin_auditing/ModelView/AgenceVM.dart';
import 'package:fin_auditing/ModelView/Journal/SiteJVM.dart';
import 'package:fin_auditing/ModelView/JournalVM.dart';

import 'package:fin_auditing/Views/Pages/SplashView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ModelView/Journal/AgenceJVM.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(create: (_) => AgenceVM()),
        ListenableProvider(create: (_) => JournalVM()),
        ListenableProvider(create: (_) => AgenceJVM()),
        ListenableProvider(create: (_) => SiteJVM()),


      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'FinAuditing',
        debugShowCheckedModeBanner: false,
        home: SplashView());
  }
}
