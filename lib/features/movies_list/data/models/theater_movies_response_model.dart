import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'theater_movies_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TheaterMoviesResponseModel {
  final DatesModel dates;
  final int page;
  final List<MovieModel> results;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  @JsonKey(name: 'total_results')
  final int totalResults;

  const TheaterMoviesResponseModel({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory TheaterMoviesResponseModel.fromJson(Map<String, dynamic> json) => _$TheaterMoviesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TheaterMoviesResponseModelToJson(this);
}
