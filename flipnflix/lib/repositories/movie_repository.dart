import 'package:dio/dio.dart';
import 'package:flipnflix/app_config.dart';
import 'package:flipnflix/models/movie.dart';

class MovieRepository {
  final Dio client = Dio(BaseOptions(
      baseUrl: AppConfig.instance.baseUrl,
      headers: {'Authorization': 'Bearer ${AppConfig.instance.token}'}));

  Future<List<Movie>> getMovies() async {
    final response = await client.get('/discover/movie', queryParameters: {"page": 1});

    return (response.data['results'] as List)
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

  Future<Movie> getMovieDetail(int id) async {
    final response = await client.get('/movie/$id');

    return Movie.fromDetailsJson(response.data);
  }
}
