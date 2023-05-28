import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unlimited_heap_ap401/screens/DemoHomePage.dart';
import 'theme/MainTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // farsi
      ],
      debugShowCheckedModeBanner: false,
      theme: buildThemeData(),
      home: const DemoHomePage(title: 'Unlimited Heap AP 401'),
    );
  }
}