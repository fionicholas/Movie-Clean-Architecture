import 'package:equatable/equatable.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchedWatchlistMovie extends WatchlistMovieEvent {
  FetchedWatchlistMovie();

  @override
  List<Object> get props => [];
}