import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchedTvShowDetail extends TvShowDetailEvent {
  final int id;

  FetchedTvShowDetail(this.id);

  @override
  List<Object> get props => [id];
}

class FetchedTvShowRecommendations extends TvShowDetailEvent {
  final int id;

  FetchedTvShowRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class FetchedTvShowWatchListStatus extends TvShowDetailEvent {
  final int id;

  FetchedTvShowWatchListStatus(this.id);

  @override
  List<Object> get props => [id];
}

class AddedWatchlistTvShow extends TvShowDetailEvent {
  final TvShowDetail tvShowDetail;

  AddedWatchlistTvShow(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}

class RemovedWatchlistTvShow extends TvShowDetailEvent {
  final TvShowDetail tvShowDetail;

  RemovedWatchlistTvShow(this.tvShowDetail);

  @override
  List<Object> get props => [tvShowDetail];
}
