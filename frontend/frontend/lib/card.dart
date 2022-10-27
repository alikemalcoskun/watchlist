import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/movies_model.dart';
import 'package:frontend/movies_service.dart';
import 'package:frontend/popupcard.dart';

class cardWidget extends StatefulWidget {
  @override
  State<cardWidget> createState() => _cardWidgetState();
}

class _cardWidgetState extends State<cardWidget> {
  GetAllMovies _allMovies = GetAllMovies();

  List<Data> movies = [];

  @override
  void initState() {
    super.initState();
    _allMovies.fetchAllMovies().then((value) {
      if (value != null) {
        setState(() {
          movies = value.data!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: ScrollPhysics(),
        itemCount: movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          childAspectRatio: 0.5,
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 100),
        itemBuilder: (context, index) {
          return Card(
            color: Color.fromARGB(83, 158, 158, 158),
            child: Container(
              height: 290,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Image.network(
                          movies[index].poster!,
                        ),
                      ),
                      Text(
                        movies[index].title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        movies[index].director! + ", " + movies[index].year!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 9,
                          fontStyle: FontStyle.italic,
                          color: Colors.white60,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40.0),
                        child: popupCard(
                          director: movies[index].director!,
                          movie_id: movies[index].movieId!,
                          title: movies[index].title!,
                          actors: movies[index].actors!,
                          description: movies[index].description!,
                          genre: movies[index].genre!,
                          poster: movies[index].poster!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
