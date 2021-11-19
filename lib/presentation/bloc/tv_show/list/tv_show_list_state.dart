import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class TvShowListState extends Equatable {
  const TvShowListState();

  @override
  List<Object> get props => [];
}

class NowPlayingTvShowListLoading extends TvShowListState {}

class NowPlayingTvShowListError extends TvShowListState {
  final String message;

  NowPlayingTvShowListError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingTvShowListHasData extends TvShowListState {
  final List<TvShow> result;

  NowPlayingTvShowListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowListEmpty extends TvShowListState {}

class PopularTvShowListLoading extends TvShowListState {}

class PopularTvShowListError extends TvShowListState {
  final String message;

  PopularTvShowListError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvShowListHasData extends TvShowListState {
  final List<TvShow> result;

  PopularTvShowListHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvShowListLoading extends TvShowListState {}

class TopRatedTvShowListError extends TvShowListState {
  final String message;

  TopRatedTvShowListError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvShowListHasData extends TvShowListState {
  final List<TvShow> result;

  TopRatedTvShowListHasData(this.result);

  @override
  List<Object> get props => [result];
}