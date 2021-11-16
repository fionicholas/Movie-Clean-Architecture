import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvShowDetail extends Equatable {
  TvShowDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
  });

  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalName;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final String name;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  @override
  List<Object?> get props => [
        backdropPath,
        genres,
        id,
        originalName,
        overview,
        posterPath,
        releaseDate,
        name,
        voteAverage,
        voteCount,
        numberOfSeasons,
        numberOfEpisodes,
      ];
}
