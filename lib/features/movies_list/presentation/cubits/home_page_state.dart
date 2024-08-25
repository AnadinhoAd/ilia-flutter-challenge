part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState extends Equatable {}

final class HomePageInitialState extends HomePageState {
  @override
  List<Object?> get props => [];
}

final class HomePageLoadingState extends HomePageState {
  @override
  List<Object?> get props => [];
}

final class HomePageLoadedState extends HomePageState {
  final TheaterMoviesResponse theaterMoviesResponse;

  HomePageLoadedState(this.theaterMoviesResponse);

  @override
  List<Object?> get props => [theaterMoviesResponse];
}
