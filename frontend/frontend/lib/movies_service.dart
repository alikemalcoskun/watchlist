import 'dart:convert';
import 'package:frontend/movies_model.dart';
import 'package:http/http.dart' as http;

final String url = "http://127.0.0.1:8000/api/";

class GetAllMovies {
  final String get_all_url = url + "get-all-movies";

  Future<MoviesModel?> fetchAllMovies() async {
    var res = await http.get(Uri.parse(get_all_url));

    if (res.statusCode == 200) {
      var json = MoviesModel.fromJson(jsonDecode(res.body));
      return json;
    } else {
      print("Error: => ${res.statusCode}");
    }
  }
}

class Roulette {
  final String roulette_url = url + "random-movie";

  Future<MoviesModel?> fetchRoulette() async {
    var res = await http.get(Uri.parse(roulette_url));

    if (res.statusCode == 200) {
      var json = MoviesModel.fromJson(jsonDecode(res.body));
      return json;
    } else {
      print("Error: => ${res.statusCode}");
    }
  }
}

class AddMovie {
  final String add_movie_url = url + "add-movie/";

  AddMovie(String movietitle) {
    var jsondata = {
      'movie_id': 'string',
      'title': movietitle,
      'director': 'string',
      'year': 'string',
      'description': 'string',
      'actors': 'string',
      'genre': 'string',
      'poster': 'string',
      'group': 'string'
    };
    try {
      var response = http.post(Uri.parse(add_movie_url),
          body: jsonEncode(jsondata),
          headers: {"Content-type": "application/json"});
    } catch (e) {
      print(e);
    }
  }
}
