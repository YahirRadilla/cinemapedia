import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';
import '../../providers/providers.dart';

final movieRecomendationProvider = FutureProvider.family((ref, int id) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getRecommendationsById(id);
});

class MovieRecommendationHorizontal extends ConsumerWidget {
  final int movieId;
  const MovieRecommendationHorizontal({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieRecommendation = ref.watch(movieRecomendationProvider(movieId));

    return movieRecommendation.when(
      data: (movie) => _Recommendations(movies: movie),
      error: (_, __) =>
          const Center(child: Text('No se pudo cargar películas similares')),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _Recommendations extends StatelessWidget {
  final List<Movie> movies;
  const _Recommendations({required this.movies});

  @override
  Widget build(BuildContext context) {
    return MovieHorizontalListview(
      movies: movies,
      title: 'Recomendaciones',
    );
  }
}
