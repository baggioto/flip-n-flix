import 'package:flipnflix/models/movie.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final path = "https://image.tmdb.org/t/p/original${movie.imagePath}";

    return Container(
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
    );
  }
}
