import 'package:fpdart/fpdart.dart';
import 'package:movie_catalog/core/error/failure.dart';
import 'package:movie_catalog/core/use_case/use_case.dart';
import 'package:movie_catalog/features/movie_details/data/repositories/movie_videos_response_repository_impl.dart';
import 'package:movie_catalog/features/movie_details/domain/entities/movie_videos_response.dart';
import 'package:movie_catalog/features/movie_details/domain/repositories/movie_videos_response_repository.dart';

class GetMovieVideosResponseUseCase implements UseCase {
  final MovieVideosResponseRepository movieVideosResponseRepository = MovieVideosResponseRepositoryImpl();

  @override
  Future<Either<Failure, MovieVideosResponse>> call(id) async {
    final movieVideosResponse = await movieVideosResponseRepository.getMovieVideosResponse(id: id);

    return movieVideosResponse;
  }
}
