import 'package:movie_catalog/core/common/entities/genre.dart';

class MovieDetails {
  final bool adult;
  final int budget;
  final List<Genre> genres;
  final int id;
  final String imdbId;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String status;
  final String title;
  final double voteAverage;

  const MovieDetails({
    required this.adult,
    required this.budget,
    required this.genres,
    required this.id,
    required this.imdbId,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.status,
    required this.title,
    required this.voteAverage,
  });
}
