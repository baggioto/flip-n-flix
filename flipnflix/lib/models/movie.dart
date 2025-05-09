import 'package:flipnflix/models/genre.dart';
import 'package:intl/intl.dart';

class Movie {
  final int id;
  final String? title;
  final String? imagePath;
  final String? overview;
  final List<Genre>? genres;
  final String? releaseDate;
  final bool? adult;

  Movie(
      {required this.id,
      this.title,
      this.imagePath,
      this.overview,
      this.genres,
      this.releaseDate,
      this.adult});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json["id"], title: json["title"], imagePath: json["poster_path"]);
  }

  factory Movie.fromDetailsJson(Map<String, dynamic> json) {
    Iterable genresFromJson = json["genres"];
    List<Genre> tempGenres =
        List<Genre>.from(genresFromJson.map((model) => Genre.fromJson(model)));

    return Movie(
        id: json["id"],
        title: json["title"],
        imagePath: json["backdrop_path"],
        overview: json["overview"],
        genres: tempGenres,
        releaseDate: json["release_date"],
        adult: json["adult"]);
  }

  String? detailMessage() {
    String? finalMessage;
    if (releaseDate != null) {
      var dateValue = DateFormat('yyyy-MM-dd').parseUTC(releaseDate!).toLocal();
      String formattedDate = DateFormat("yyyy").format(dateValue);

      finalMessage = (finalMessage ?? "") + formattedDate;
    }

    if (adult != null) {
      bool isAdult = adult!;

      if (isAdult) {
        finalMessage = "${finalMessage ?? ""} | +18";
      }
    }

    // return "$formattedDate | 18+ | K-Drama";

    return finalMessage;
  }

  String? genreMessage() {
    return "Genre: ${genres?.map((g) => g.name).join(", ")}";
  }
}
