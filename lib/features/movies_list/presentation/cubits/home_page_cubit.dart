import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_catalog/features/movies_list/domain/entities/theater_movies_response.dart';
import 'package:movie_catalog/features/movies_list/domain/use_cases/get_movies_use_case.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final getMoviesUseCase = GetMoviesUseCase();

  HomePageCubit() : super(HomePageInitialState());

  init() async {
    emit(HomePageLoadingState());
    final theaterMovies = await getMoviesUseCase.call(1);

    theaterMovies.fold(
      (l) => emit(HomePageInitialState()),
      (r) => emit(HomePageLoadedState(r)),
    );
  }
}
