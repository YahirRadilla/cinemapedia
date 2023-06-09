import '../entities/entities.dart';

abstract class MoviesRepositories {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

  Future<List<Movie>> searchMovies(String query);

  Future<List<Movie>> getRecommendationsById(int id);

  Future<List<Video>> getVideosById(int id);
}
