class MoviesModel {
  List<Data>? data;

  MoviesModel({this.data});

  MoviesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? movieId;
  String? title;
  String? director;
  String? year;
  String? description;
  String? actors;
  String? genre;
  String? poster;
  String? group;

  Data(
      {this.movieId,
      this.title,
      this.director,
      this.year,
      this.description,
      this.actors,
      this.genre,
      this.poster,
      this.group});

  Data.fromJson(Map<String, dynamic> json) {
    movieId = json['movie_id'];
    title = json['title'];
    director = json['director'];
    year = json['year'];
    description = json['description'];
    actors = json['actors'];
    genre = json['genre'];
    poster = json['poster'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['movie_id'] = this.movieId;
    data['title'] = this.title;
    data['director'] = this.director;
    data['year'] = this.year;
    data['description'] = this.description;
    data['actors'] = this.actors;
    data['genre'] = this.genre;
    data['poster'] = this.poster;
    data['group'] = this.group;
    return data;
  }
}
