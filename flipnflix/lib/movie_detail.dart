import 'dart:async';

import 'package:flipnflix/bloc/content_detail/movie/movie_detail_bloc.dart';
import 'package:flipnflix/bloc/content_detail/movie/movie_detail_event.dart';
import 'package:flipnflix/bloc/content_detail/movie/movie_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDetailScreen extends StatefulWidget {
  static const String routeName = "/moviedetail";
  const HomeDetailScreen({super.key, required this.id});
  final int id;

  @override
  State<HomeDetailScreen> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetailScreen> {
  late final MovieDetailBloc movieBloc;
  late StreamSubscription<MovieDetailState> streamSub;

  @override
  void initState() {
    super.initState();
    movieBloc = MovieDetailBloc();
    streamSub = movieBloc.stream.listen(stateListener);

    movieBloc.add(GetDetailedMovie(id: widget.id));
  }

  @override
  void dispose() {
    streamSub.cancel();
    movieBloc.close();
    super.dispose();
  }

  void stateListener(MovieDetailState state) {
    switch (state) {
      case MovieDetailSuccessState _:
        print("success");
      case MovieDetailErrorState errorState:
        showError(errorState.errorMessage);
      case MovieDetailInitialState _:
        print("initial");
      case MovieDetailLoadingState _:
        print("loading");
    }
  }

  void showError(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
  }

  String completeContentPath(String moviePath) {
    return "https://image.tmdb.org/t/p/original$moviePath";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          bloc: movieBloc,
          builder: (context, state) {
            return switch (state) {
              MovieDetailSuccessState successState => Text(
                  successState.movie.title ?? "",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              _ => SizedBox.shrink(),
            };
          },
        ),
      ),
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        bloc: movieBloc,
        builder: (context, state) {
          return switch (state) {
            MovieDetailSuccessState successState => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                      completeContentPath(successState.movie.imagePath ?? ""),
                      errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey,
                          ),
                      fit: BoxFit.fitWidth,
                      height: 200,
                      width: size.width),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(successState.movie.title ?? "",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start),
                        SizedBox(height: 10),
                        Text(successState.movie.detailMessage() ?? "",
                            style: TextStyle(
                                color: Color(0xff969696),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start),
                        SizedBox(height: 10),
                        Text(successState.movie.overview ?? "",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start),
                        SizedBox(height: 10),
                        Text(successState.movie.genreMessage() ?? "",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start),
                      ],
                    ),
                  )
                ],
              ),
            MovieDetailErrorState _ => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.redAccent, size: 40),
                    const SizedBox(height: 8),
                    Text(
                      "Erro ao carregar filme.",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            MovieDetailLoadingState _ =>
              Center(child: const CircularProgressIndicator()),
            MovieDetailInitialState _ => SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
