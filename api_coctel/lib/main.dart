import 'package:api_coctel/pages/home.dart';
import 'package:api_coctel/pages/popular.dart';
import 'package:api_coctel/pages/sin_alcohol.dart';
import 'package:flutter/material.dart';
import 'package:api_coctel/pages/alcohol.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomaPage(),
        '/home': (context) => const HomaPage(),
        '/popular': (context) => const PopularAlcoholPage(),
        '/alcohol': (context) => const AlcoholPage(),
        '/sinAlcohol': (context) => const SinAlcoholPage(),
      },
    );
  }
}
