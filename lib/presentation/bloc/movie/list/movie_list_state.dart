import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieLoading extends MovieListState {}

class NowPlayingMovieError extends MovieListState {
  final String message;

  NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMovieHasData extends MovieListState {
  final List<Movie> result;

  NowPlayingMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieListEmpty extends MovieListState {}

class PopularMovieLoading extends MovieListState {}

class PopularMovieError extends MovieListState {
  final String message;

  PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMovieHasData extends MovieListState {
  final List<Movie> result;

  PopularMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedMovieLoading extends MovieListState {}

class TopRatedMovieError extends MovieListState {
  final String message;

  TopRatedMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedMovieHasData extends MovieListState {
  final List<Movie> result;

  TopRatedMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
