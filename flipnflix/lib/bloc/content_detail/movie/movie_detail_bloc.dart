import 'package:flipnflix/bloc/content_detail/movie/movie_detail_event.dart';
import 'package:flipnflix/bloc/content_detail/movie/movie_detail_state.dart';
import 'package:flipnflix/repositories/movie_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitialState()) {
    on<GetDetailedMovie>(_fetchMovies);
  }

  Future<void> _fetchMovies(
      GetDetailedMovie event, Emitter<MovieDetailState> emitter) async {
    emitter(MovieDetailLoadingState());

    await MovieRepository().getMovieDetail(event.id).then((result) {
      emitter(MovieDetailSuccessState(movie: result));
    }).catchError((error) {
      emitter(MovieDetailErrorState(errorMessage: error.toString()));
    });
  }
}
