import 'dart:convert';

import 'package:api_coctel/models/alcohol.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

late final Future<List<DrinksAlcoholPopular>> coctelPopular;

class PopularAlcoholPage extends StatelessWidget {
  const PopularAlcoholPage({Key? key}) : super(key: key);
  @override
  void initState() {
    coctelPopular = fetchPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              FutureBuilder<List<DrinksAlcoholPopular>>(
                future: coctelPopular,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _peopleList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<DrinksAlcoholPopular>> fetchPopular() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/people'));
    if (response.statusCode == 200) {
      return AlcoholPopularResponse.fromJson(jsonDecode(response.body)).drinks;
    } else {
      throw Exception('Failed to load people');
    }
  }

  Widget _peopleList(List<DrinksAlcoholPopular> peopleList) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: peopleList.length,
        itemBuilder: (context, index) {
          return _peopleItem(peopleList.elementAt(index), index);
        },
      ),
    );
  }

  Widget _peopleItem(DrinksAlcoholPopular people, int index) {
    String personId = people.url.split('/')[5];
    String personName = people.strDrink;
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(id: personId);
        }));
      },
      child: Container(
          width: 200,
          height: 250,
          margin:
              EdgeInsets.only(left: index == 0 ? 20 : 5, right: 5, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.yellow.withOpacity(0.5), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.yellow.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Hero(
                      tag: 'people',
                      child: Image.network(
                          'http://starwars-visualguide.com/assets/img/characters/$personId.jpg',
                          width: 200,
                          fit: BoxFit.cover))),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: Container(
                          color: Colors.white.withOpacity(0.7),
                          width: 200,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            personName,
                            style: const TextStyle(fontFamily: 'Jedi'),
                          ))))
            ],
          )),
    );
  }
}

@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.blue,
    ),
    home: const MyHomePage2(title: 'Flutter Demo Home Page'),
  );
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class _MyHomePageState2 extends State<MyHomePage2> {
  late Future<List<People>> items;
  late Future<List<Planetas>> itemsPlanets;

  @override
  void initState() {
    itemsPlanets = fetchPlanets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Personajes'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage(
                            title: "Personajes",
                          )),
                );
              },
            ),
            ListTile(
              title: const Text('Planetas'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              FutureBuilder<List<Planetas>>(
                future: itemsPlanets,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _planetsList(snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getPlanetImg(int index, String name) {
    if (name == 'Tatooine') {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Image.network(
            'https://static.wikia.nocookie.net/esstarwars/images/b/b0/Tatooine_TPM.png/revision/latest?cb=20131214162357'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Image.network(
            'https://starwars-visualguide.com/assets/img/planets/' +
                (index + 1).toString() +
                '.jpg',
            width: 150),
      );
    }
  }

  Future<List<Planetas>> fetchPlanets() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/planets'));
    if (response.statusCode == 200) {
      return StarPlanets.fromJson(jsonDecode(response.body)).results;
    } else {
      throw Exception('Failed to load planets');
    }
  }

  Widget _planetsList(List<Planetas> planetsList) {
    return SizedBox(
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: planetsList.length,
        itemBuilder: (context, index) {
          return _planetItem(planetsList.elementAt(index), index);
        },
      ),
    );
  }

  Widget _planetItem(Planetas planet, int index) {
    return Container(
        margin: const EdgeInsets.only(left: 10, bottom: 10),
        width: 150,
        child: Card(
          child: InkWell(
            splashColor: Colors.red.withAlpha(30),
            onTap: () {
              debugPrint('Card tapped.');
            },
            child: SizedBox(
              width: 300,
              height: 150,
              child: Column(
                children: [
                  Text(planet.name),
                  _getPlanetImg(index, planet.name)
                ],
              ),
            ),
          ),
        ));
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
