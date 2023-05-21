import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(
                        movie: movie,
                      ),
                  childCount: 1))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 10,
              ),

              //Description

              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: textStyles.titleLarge,
                    ),
                    Text(
                      movie.overview.isNotEmpty
                          ? movie.overview
                          : 'Sin descripción',
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        //Generos de la pelicula

        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((gender) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Chip(
                      label: Text(gender),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ))
            ],
          ),
        ),

        _ActorsByMovie(movieId: movie.id.toString()),

        VideosFromMovie(movieId: movie.id),

        MovieRecommendationHorizontal(movieId: movie.id)
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (BuildContext context, int index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Actor photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage(
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        actor.profilePath,
                      ),
                      placeholder:
                          const AssetImage('assets/loaders/bottle-loader.gif'),
                    ),
                  ),
                ),

                //name

                const SizedBox(
                  height: 5,
                ),

                Text(
                  actor.name,
                  maxLines: 2,
                ),
                Text(
                  actor.character ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return localStorageRepository.isMoviesFavorite(movieId);
});

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
      actions: [
        IconButton(
            onPressed: () async {
              await ref
                  .read(favoriteMoviesProvider.notifier)
                  .toggleFavorite(movie);
              ref.invalidate(isFavoriteProvider(movie.id));
            },
            icon: isFavoriteFuture.when(
              loading: () => const CircularProgressIndicator(
                strokeWidth: 2,
              ),
              data: (isFavorite) => isFavorite
                  ? const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border_outlined),
              error: (_, __) => throw UnimplementedError('error'),
            )
            //const Icon(Icons.favorite_border_outlined)

            //icon: const Icon(Icons.favorite,color: Colors.red,)
            )
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(bottom: 0),
        title: _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.7, 1.0],
            colors: [Colors.transparent, scaffoldBackgroundColor]),
        /* title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ), */
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.3],
              colors: [Colors.black54, Colors.transparent],
            ),
            const _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54],
            ),
            const _CustomGradient(
              begin: Alignment.topLeft,
              end: Alignment.center,
              stops: [0.0, 0.3],
              colors: [Colors.black54, Colors.transparent],
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;
  const _CustomGradient(
      {required this.begin,
      required this.stops,
      required this.colors,
      required this.end});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: begin, end: end, stops: stops, colors: colors))),
    );
  }
}
