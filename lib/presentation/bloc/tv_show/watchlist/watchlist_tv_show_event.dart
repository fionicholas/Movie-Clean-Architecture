import 'package:equatable/equatable.dart';

abstract class WatchlistTvShowEvent extends Equatable {
  const WatchlistTvShowEvent();

  @override
  List<Object> get props => [];
}

class FetchedWatchlistTvShow extends WatchlistTvShowEvent {
  FetchedWatchlistTvShow();

  @override
  List<Object> get props => [];
}