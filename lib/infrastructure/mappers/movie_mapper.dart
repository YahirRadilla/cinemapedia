import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie moveDBToEntity(MovieMovieDB movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath: (movieDb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: (movieDb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
      releaseDate:
          movieDb.releaseDate != null ? movieDb.releaseDate! : DateTime.now(),
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath: (movieDb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
      genreIds: movieDb.genres.map((e) => e.name).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: (movieDb.posterPath != '')
          ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqLk01yOS0nLVJdaOmZ-4LrAUklNeiBVpNDKQR8_IDyrdtE6Yww2woixd0S27ckXGTnLA&usqp=CAU',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);
}
