import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoader = ref.watch(initialLoadingProvider);
    if (initialLoader) return const FullScreenLoader();
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.zero,
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            //const CustomAppbar(),
            MoviesSlideshow(movies: slideShowMovies),
            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subTitle: 'Lunes 20',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: upcomingMovies,
              title: 'Proximamente',
              subTitle: 'En este mes',
              loadNextPage: () =>
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor calificadas',
              subTitle: 'Desde siempre',
              loadNextPage: () =>
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1)),
    ]);
  }
}
