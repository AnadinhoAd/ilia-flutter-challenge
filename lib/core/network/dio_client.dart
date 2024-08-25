import 'package:dio/dio.dart';
import 'package:movie_catalog/core/constants/constants.dart';
import 'package:movie_catalog/features/movies_list/data/models/models.dart';

enum CallPath {
  theaterMovies('/movie/now_playing'),
  genres('/genre/movie/list'),
  movieDetail('/genre/movie/');

  final String path;

  const CallPath(this.path);
}

class DioClient {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      queryParameters: {
        'api_key': '272d06dc4ffb8bb135e00c83be1e7dc2',
        'language': 'pt-BR',
        'region': 'br',
      },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<TheaterMoviesResponseModel> getTheaterMovies(int page) async {
    try {
      dio.options.queryParameters.addEntries([MapEntry('page', page)]);
      final response = await dio.get(CallPath.theaterMovies.path);
      final theaterMovies = TheaterMoviesResponseModel.fromJson(response.data);
      dio.options.queryParameters.remove('page');

      return theaterMovies;
    } on DioException {
      rethrow;
    }
  }
}
