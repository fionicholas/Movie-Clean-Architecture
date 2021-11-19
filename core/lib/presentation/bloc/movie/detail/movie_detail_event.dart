import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchedMovieDetail extends MovieDetailEvent {
  final int id;

  FetchedMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchedMovieRecommendations extends MovieDetailEvent {
  final int id;

  FetchedMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class FetchedWatchListStatus extends MovieDetailEvent {
  final int id;

  FetchedWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddedWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movieDetail;

  AddedWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemovedWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movieDetail;

  RemovedWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}
