import 'package:equatable/equatable.dart';

abstract class TopRatedMovieEvent extends Equatable {
  const TopRatedMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchedTopRatedMovie extends TopRatedMovieEvent {
  FetchedTopRatedMovie();

  @override
  List<Object> get props => [];
}
