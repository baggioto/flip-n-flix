import 'package:flipnflix/models/movie.dart';

sealed class MovieDetailState {}

class MovieDetailSuccessState extends MovieDetailState {
  final Movie movie;

  MovieDetailSuccessState({required this.movie});
}

class MovieDetailErrorState extends MovieDetailState {
  final String errorMessage;

  MovieDetailErrorState({required this.errorMessage});
}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailInitialState extends MovieDetailState {}
