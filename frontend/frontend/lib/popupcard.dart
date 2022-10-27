import 'package:flutter/material.dart';
import 'package:frontend/card.dart';
import 'package:frontend/movies_service.dart';
import 'package:http/http.dart' as http;

import 'movies_model.dart';

class popupCard extends StatelessWidget {
  String movie_id;
  String title;
  String director;
  String description;
  String actors;
  String genre;
  String poster;

  popupCard({
    required this.movie_id,
    required this.title,
    required this.director,
    required this.description,
    required this.actors,
    required this.genre,
    required this.poster,
  });

  final String delete_url = 'http://127.0.0.1:8000/api/delete-movie/';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style:
            OutlinedButton.styleFrom(side: BorderSide(color: Colors.white60)),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.white60),
                ),
                Text(
                  ' ' + director,
                  style: TextStyle(
                      color: Colors.white30, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            backgroundColor: Color.fromARGB(255, 69, 90, 100),
            content: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          poster,
                          height: 350.0,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          description,
                          style: TextStyle(color: Colors.white60),
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.right,
                        ),
                        Text('Starring',
                            style: TextStyle(
                                color: Colors.white30, fontSize: 18.0)),
                        Text(
                          actors,
                          style: TextStyle(color: Colors.white60),
                        ),
                        Text('Genre',
                            style: TextStyle(
                                color: Colors.white30, fontSize: 18.0)),
                        Text(
                          genre,
                          style: TextStyle(color: Colors.white60),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  http.delete(
                    Uri.parse(delete_url + title),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                  );
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "'" + title + "' was removed from your watchlist."),
                  ));
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.white60,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
        child: const Text(
          'Details',
          overflow: TextOverflow.clip,
          style: TextStyle(color: Colors.white60),
        ),
      ),
    );
  }
}

class RouletteWidget extends StatefulWidget {
  const RouletteWidget({Key? key}) : super(key: key);

  @override
  State<RouletteWidget> createState() => _RouletteWidgetState();
}

class _RouletteWidgetState extends State<RouletteWidget> {
  Roulette _roulette = Roulette();

  List<Data> movies = [];

  @override
  void initState() {
    super.initState();
    _roulette.fetchRoulette().then((value) {
      if (value != null) {
        setState(() {
          movies = value.data!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white60)),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Row(
            children: [
              Text(
                movies[0].title!,
                style: TextStyle(color: Colors.white60),
              ),
              Text(
                ' ' + movies[0].director!,
                style: TextStyle(
                    color: Colors.white30, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 69, 90, 100),
          content: Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0),
                      child: Image.network(
                        movies[0].poster!,
                        height: 350.0,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      movies[0].description!,
                      style: TextStyle(color: Colors.white60),
                      overflow: TextOverflow.visible,
                    ),
                    Text('Starring',
                        style:
                            TextStyle(color: Colors.white30, fontSize: 18.0)),
                    Text(
                      movies[0].actors!,
                      style: TextStyle(color: Colors.white60),
                    ),
                    Text('Genre',
                        style:
                            TextStyle(color: Colors.white30, fontSize: 18.0)),
                    Text(
                      movies[0].genre!,
                      style: TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              )
            ],
          )),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text(
        'Roulette',
        style: TextStyle(color: Colors.white60),
      ),
    );
  }
}
