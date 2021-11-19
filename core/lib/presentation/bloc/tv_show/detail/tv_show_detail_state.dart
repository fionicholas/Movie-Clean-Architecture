import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object> get props => [];
}

class TvShowDetailEmpty extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailError extends TvShowDetailState {
  final String message;

  TvShowDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowDetailHasData extends TvShowDetailState {
  final TvShowDetail result;

  TvShowDetailHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowRecommendationsLoading extends TvShowDetailState {}

class TvShowRecommendationsError extends TvShowDetailState {
  final String message;

  TvShowRecommendationsError(this.message);

  @override
  List<Object> get props => [message];
}

class TvShowRecommendationsHasData extends TvShowDetailState {
  final List<TvShow> result;

  TvShowRecommendationsHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowWatchlistStatusLoading extends TvShowDetailState {}

class TvShowWatchlistStatusHasData extends TvShowDetailState {
  final bool result;

  TvShowWatchlistStatusHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TvShowWatchlistStatusError extends TvShowDetailState {
  final String message;

  TvShowWatchlistStatusError(this.message);

  @override
  List<Object> get props => [message];
}

class AddTvShowWatchlistLoading extends TvShowDetailState {}

class AddTvShowWatchlistError extends TvShowDetailState {
  final String message;

  AddTvShowWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class AddTvShowWatchlistSuccess extends TvShowDetailState {
  final String message;

  AddTvShowWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveTvShowWatchlistLoading extends TvShowDetailState {}

class RemoveTvShowWatchlistError extends TvShowDetailState {
  final String message;

  RemoveTvShowWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class RemoveTvShowWatchlistSuccess extends TvShowDetailState {
  final String message;

  RemoveTvShowWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}
