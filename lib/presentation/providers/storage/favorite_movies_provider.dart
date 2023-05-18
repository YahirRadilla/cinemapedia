import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repositorie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepositorie = ref.watch(localStorageRepositoryProvider);
  return StorageMoviesNotifier(
      localStorageRepositorie: localStorageRepositorie);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepositorie localStorageRepositorie;

  StorageMoviesNotifier({required this.localStorageRepositorie}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies =
        await localStorageRepositorie.loadMovies(offset: page * 10, limit: 20);
    page++;

    final tempMoviesMap = <int, Movie>{};

    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localStorageRepositorie.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;
    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
      return;
    }

    state = {...state, movie.id: movie};
  }
}
