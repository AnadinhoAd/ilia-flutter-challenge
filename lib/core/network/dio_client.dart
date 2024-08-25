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
      responseType: ResponseType.json,
    ),
  );

  Future<TheaterMoviesResponseModel> getTheaterMovies(int page) async {
    try {
      final response = await dio.get('${CallPath.theaterMovies.path}/$page');
      final theaterMovies = TheaterMoviesResponseModel.fromJson(response.data);

      return theaterMovies;
    } on DioException {
      rethrow;
    }
  }
}
