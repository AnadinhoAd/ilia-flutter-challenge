import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_catalog/features/movies_list/domain/entities/movie.dart';
import 'package:movie_catalog/features/movies_list/domain/use_cases/get_movies_use_case.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final getMoviesUseCase = GetMoviesUseCase();

  HomePageCubit() : super(HomePageInitialState());

  int _page = 1;
  List<Movie> currentTheaterMovies = [];

  Future init() async {
    emit(HomePageLoadingState());
    final theaterMoviesResponse = await getMoviesUseCase.call(_page);

    theaterMoviesResponse.fold(
      (l) => emit(HomePageInitialState()),
      (r) {
        currentTheaterMovies.addAll(r.results);
        emit(
          HomePageLoadedState(
            theaterMoviesResponse: currentTheaterMovies,
            isLoadingMoreMovies: false,
          ),
        );
      },
    );
  }

  Future fetchMoreMovies() async {
    emit(
      HomePageLoadedState(
        theaterMoviesResponse: currentTheaterMovies,
        isLoadingMoreMovies: true,
      ),
    );

    _page++;

    final theaterMoviesResponse = await getMoviesUseCase.call(_page);

    theaterMoviesResponse.fold(
      (l) => emit(HomePageInitialState()),
      (r) async {
        currentTheaterMovies.addAll(r.results);

        await Future.delayed(const Duration(seconds: 2));
        emit(HomePageLoadedState(
          theaterMoviesResponse: currentTheaterMovies,
          isLoadingMoreMovies: false,
        ));
      },
    );
  }
}
