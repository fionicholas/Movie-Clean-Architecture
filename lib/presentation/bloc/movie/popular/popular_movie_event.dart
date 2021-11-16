import 'package:equatable/equatable.dart';

abstract class PopularMovieEvent extends Equatable {
  const PopularMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchedPopularMovie extends PopularMovieEvent {
  FetchedPopularMovie();

  @override
  List<Object> get props => [];
}
