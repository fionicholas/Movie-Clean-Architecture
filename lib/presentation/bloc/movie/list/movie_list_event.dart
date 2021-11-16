import 'package:equatable/equatable.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class FetchedNowPlayingMovie extends MovieListEvent {
  FetchedNowPlayingMovie();

  @override
  List<Object> get props => [];
}

class FetchedPopularMovie extends MovieListEvent {
  FetchedPopularMovie();

  @override
  List<Object> get props => [];
}

class FetchedTopRatedMovie extends MovieListEvent {
  FetchedTopRatedMovie();

  @override
  List<Object> get props => [];
}
