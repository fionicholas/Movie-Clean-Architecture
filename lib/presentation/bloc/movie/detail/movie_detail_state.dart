import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;

  MovieDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieRecommendationsLoading extends MovieDetailState {}

class MovieRecommendationsError extends MovieDetailState {
  final String message;

  MovieRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationsHasData extends MovieDetailState {
  final List<Movie> result;

  MovieRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistStatusLoading extends MovieDetailState {}

class WatchlistStatusHasData extends MovieDetailState {
  final bool result;

  WatchlistStatusHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistStatusError extends MovieDetailState {
  final String message;

  WatchlistStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class AddWatchlistLoading extends MovieDetailState {}

class AddWatchlistError extends MovieDetailState {
  final String message;

  AddWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class AddWatchlistSuccess extends MovieDetailState {
  final String message;

  AddWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlistLoading extends MovieDetailState {}

class RemoveWatchlistError extends MovieDetailState {
  final String message;

  RemoveWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveWatchlistSuccess extends MovieDetailState {
  final String message;

  RemoveWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}
