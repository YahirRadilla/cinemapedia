import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class PopularsView extends ConsumerStatefulWidget {
  const PopularsView({super.key});

  @override
  PopularsViewState createState() => PopularsViewState();
}

class PopularsViewState extends ConsumerState<PopularsView> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    await ref.read(popularMoviesProvider.notifier).loadNextPage();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final popularMovies = ref.watch(popularMoviesProvider);

    return Scaffold(
        body: MovieMasonry(
      movies: popularMovies,
      loadNextPage: loadNextPage,
    ));
  }
}
