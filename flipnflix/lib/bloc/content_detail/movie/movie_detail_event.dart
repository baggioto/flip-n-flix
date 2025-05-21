sealed class MovieDetailEvent {}

class GetDetailedMovie extends MovieDetailEvent{
  final int id;

  GetDetailedMovie({required this.id});
}