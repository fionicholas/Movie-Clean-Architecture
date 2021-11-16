import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class TopRatedTvShowState extends Equatable {
  const TopRatedTvShowState();

  @override
  List<Object> get props => [];
}

class TopRatedTvShowEmpty extends TopRatedTvShowState {}

class TopRatedTvShowLoading extends TopRatedTvShowState {}

class TopRatedTvShowError extends TopRatedTvShowState {
  final String message;

  TopRatedTvShowError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedTvShowHasData extends TopRatedTvShowState {
  final List<TvShow> result;

  TopRatedTvShowHasData(this.result);

  @override
  List<Object> get props => [result];
}
