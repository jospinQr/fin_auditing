import 'package:fin_auditing/Public/Views/Pages/SplashView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Comptablite/ViewModel/Bilan/NatureVM.dart';
import 'Comptablite/ViewModel/Gand Livre/CompteVM.dart';
import 'Comptablite/ViewModel/Journal/AgenceJVM.dart';
import 'Comptablite/ViewModel/Journal/DateopJVM.dart';

import 'Comptablite/ViewModel/Journal/JournalVM.dart';
import 'Comptablite/ViewModel/Journal/OperationJVM.dart';
import 'Comptablite/ViewModel/Journal/SiteJVM.dart';
import 'Comptablite/ViewModel/TypeRapportVM.dart';
import 'Public/ViewModel/AgenceVM.dart';
import 'Public/ViewModel/ExerciceVM.dart';
import 'Public/ViewModel/SiteVM.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(create: (_) => AgenceVM()),
        ListenableProvider(create: (_) => JournalVM()),
        ListenableProvider(create: (_) => AgenceJVM()),
        ListenableProvider(create: (_) => SiteJVM()),
        ListenableProvider(create: (_) => SiteVM()),
        ListenableProvider(create: (_) => DateopJVM()),
        ListenableProvider(create: (_) => ExerciceVM()),
        ListenableProvider(create: (_) => OperationJVM()),
        ListenableProvider(create: (_) => TypeRapportVM()),
        ListenableProvider(create: (_) => NatureVM()),
        ListenableProvider(create: (_) => CompteVM()),

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
