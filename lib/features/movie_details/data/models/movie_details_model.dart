import 'package:movie_catalog/features/movie_details/data/models/genre_model.dart';
import 'package:movie_catalog/features/movie_details/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetails {
  MovieDetailsModel({
    required super.adult,
    required super.budget,
    required super.genres,
    required super.id,
    required super.imdbId,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.releaseDate,
    required super.runtime,
    required super.status,
    required super.title,
    required super.voteAverage,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      adult: json['adult'],
      budget: json['budget'],
      genres: (json['genres'] as List).map((genreJson) => GenreModel.fromJson(genreJson)).toList(),
      id: json['id'],
      imdbId: json['imdb_id'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      status: json['status'],
      title: json['title'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
