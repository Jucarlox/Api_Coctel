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
        '/': (context) => const HomePage(),
        '/alcohol': (context) => const (),
        '/films': (context) => const FilmsPage(),
        '/people': (context) => const PeoplePage(),
        '/film-detail': (context) => const FilmsDetailPage(),
      },
    );
  }
}