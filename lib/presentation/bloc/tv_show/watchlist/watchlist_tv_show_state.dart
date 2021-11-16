import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class WatchlistTvShowState extends Equatable {
  const WatchlistTvShowState();

  @override
  List<Object> get props => [];
}

class WatchlistTvShowEmpty extends WatchlistTvShowState {}

class WatchlistTvShowLoading extends WatchlistTvShowState {}

class WatchlistTvShowError extends WatchlistTvShowState {
  final String message;

  WatchlistTvShowError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvShowHasData extends WatchlistTvShowState {
  final List<TvShow> result;

  WatchlistTvShowHasData(this.result);

  @override
  List<Object> get props => [result];
}
