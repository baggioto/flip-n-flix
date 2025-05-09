import 'package:flipnflix/components/loading_movie_list.dart';
import 'package:flipnflix/components/movie_card.dart';
import 'package:flipnflix/components/movie_list_error.dart';
import 'package:flipnflix/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('images/home_banner.png',
            fit: BoxFit.cover, scale: .8, width: double.infinity),
        const SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Popular Movies",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              const SizedBox(height: 12),
              FutureBuilder(
                  future: MovieRepository().getMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingMovieList();
                    }

                    if (snapshot.hasError) {
                      return MovieListError(onRetry: () {});
                    }

                    final movies = snapshot.data ?? [];

                    return SizedBox(
                      height: 180,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(movie: movies[index]);
                          }),
                    );
                  })
            ],
          ),
        )
      ],
    );
  }
}
