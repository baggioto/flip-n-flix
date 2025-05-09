import 'package:flipnflix/models/movie.dart';
import 'package:flipnflix/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class HomeDetailScreen extends StatefulWidget {
  const HomeDetailScreen({super.key, required this.id});
  final int id;

  @override
  State<HomeDetailScreen> createState() => _HomeDetailState();
}

class _HomeDetailState extends State<HomeDetailScreen> {
  Movie? movie;

  @override
  void initState() {
    super.initState();
    getMovie();
  }

  void getMovie() async {
    await MovieRepository().getMovieDetail(widget.id).then((result) {
      setState(() {
        movie = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String? path;
    if (movie != null) {
      path = "https://image.tmdb.org/t/p/original${movie?.imagePath}";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie?.title ?? "",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(path ?? "",
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
                Text(movie?.title ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.start),
                SizedBox(height: 10),
                Text(movie?.detailMessage() ?? "",
                    style: TextStyle(
                        color: Color(0xff969696),
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start),
                SizedBox(height: 10),
                Text(movie?.overview ?? "",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start),
                SizedBox(height: 10),
                Text(movie?.genreMessage() ?? "",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start),
              ],
            ),
          )
        ],
      ),
    );
  }
}
