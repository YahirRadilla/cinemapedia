import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepositorie {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMoviesFavorite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
