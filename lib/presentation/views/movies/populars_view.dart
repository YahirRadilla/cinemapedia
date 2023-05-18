import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularsView extends ConsumerStatefulWidget {
  const PopularsView({super.key});

  @override
  PopularsViewState createState() => PopularsViewState();
}

class PopularsViewState extends ConsumerState<PopularsView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    return Scaffold(
        body: MovieMasonry(
      movies: favoriteMovies,
      loadNextPage: loadNextPage,
    ));
  }
}
