import 'package:fin_auditing/ViewModel/AgenceVM.dart';
import 'package:fin_auditing/ViewModel/Journal/DateopJVM.dart';
import 'package:fin_auditing/ViewModel/Journal/SiteJVM.dart';
import 'package:fin_auditing/ViewModel/Journal/JournalVM.dart';
import 'package:fin_auditing/Views/Pages/SplashView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ViewModel/Journal/ExerciceVM.dart';
import '../ViewModel/Journal/AgenceJVM.dart';
import '../ViewModel/Journal/OperationJVM.dart';
import '../ViewModel/TypeRapportVM.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(create: (_) => AgenceVM()),
        ListenableProvider(create: (_) => JournalVM()),
        ListenableProvider(create: (_) => AgenceJVM()),
        ListenableProvider(create: (_) => SiteJVM()),
        ListenableProvider(create: (_) => DateopJVM()),
        ListenableProvider(create: (_) => ExerciceVM()),
        ListenableProvider(create: (_) => OperationJVM()),
        ListenableProvider(create: (_) => TypeRapportVM()),
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
