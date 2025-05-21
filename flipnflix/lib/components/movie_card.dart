import 'package:flipnflix/home_page.dart';
import 'package:flipnflix/models/movie.dart';
import 'package:flipnflix/movie_detail.dart';
import 'package:flipnflix/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final path = "https://image.tmdb.org/t/p/original${movie.imagePath}";

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 8),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Image.network(path,
            errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey,
                ),
            fit: BoxFit.cover,
            height: 180,
            width: 120),
      ),
      onTap: () {
        context.go(subRoute(HomePage.routeName, HomeDetailScreen.routeName), extra: movie.id);
      },
    );
  }
}
