import 'package:flutter/material.dart';
import 'package:frontend/card.dart';
import 'package:frontend/movies_service.dart';
import 'package:frontend/popupcard.dart';
import 'package:http/http.dart';
import 'movies_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController movieTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist+',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist+'),
          backgroundColor: Color.fromARGB(255, 69, 90, 100),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 180,
                    child: TextFormField(
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter movie title',
                          labelStyle:
                              TextStyle(color: Colors.white30, fontSize: 15.0),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                        ),
                        controller: movieTitleController,
                        style: TextStyle(color: Colors.white60)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: OutlinedButton(
                      onPressed: () async {
                        AddMovie(movieTitleController.text);
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white60),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white60)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: RouletteWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 55, 71, 79),
              Color.fromARGB(255, 38, 50, 56),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(top: 70.0),
                    child: cardWidget()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
