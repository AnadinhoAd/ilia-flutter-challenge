import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_catalog/core/error/failure.dart';
import 'package:movie_catalog/features/movie_details/data/data_sources/movie_details_remote_data_source.dart';
import 'package:movie_catalog/features/movie_details/domain/entities/movie_details.dart';
import 'package:movie_catalog/features/movie_details/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  MovieDetailsRemoteDataSource movieDetailsRemoteDataSource = MovieDetailsRemoteDataSourceImpl();

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails({required int id}) async {
    try {
      return Right(
        await movieDetailsRemoteDataSource.getMovieDetails(id),
      );
    } on DioException catch (e) {
      return Left(
        Failure(
          errorMessage: e.message ?? '',
        ),
      );
    }
  }
}
