// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theater_movies_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TheaterMoviesResponseModel _$TheaterMoviesResponseModelFromJson(
        Map<String, dynamic> json) =>
    TheaterMoviesResponseModel(
      dates: DatesModel.fromJson(json['dates'] as Map<String, dynamic>),
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: (json['total_pages'] as num).toInt(),
      totalResults: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$TheaterMoviesResponseModelToJson(
        TheaterMoviesResponseModel instance) =>
    <String, dynamic>{
      'dates': instance.dates.toJson(),
      'page': instance.page,
      'results': instance.results.map((e) => e.toJson()).toList(),
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
