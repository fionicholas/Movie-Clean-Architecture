import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_status.dart';
import 'package:core/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:core/domain/usecases/tv_show/save_watchlist.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_event.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowDetailBloc extends Bloc<TvShowDetailEvent, TvShowDetailState> {
  final GetTvShowDetail _getTvShowDetail;
  final GetTvShowRecommendations _getTvShowRecommendations;
  final GetWatchListTvShowStatus _getWatchListTvShowStatus;
  final SaveWatchlistTvShow _saveWatchlistTvShow;
  final RemoveWatchlistTvShow _removeWatchlistTvShow;

  TvShowDetailBloc(
      this._getTvShowDetail,
      this._getTvShowRecommendations,
      this._getWatchListTvShowStatus,
      this._saveWatchlistTvShow,
      this._removeWatchlistTvShow)
      : super(TvShowDetailEmpty());

  @override
  Stream<TvShowDetailState> mapEventToState(
    TvShowDetailEvent event,
  ) async* {
    if (event is FetchedTvShowDetail) {
      yield TvShowDetailLoading();
      final result = await _getTvShowDetail.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield TvShowDetailError(failure.message);
        },
        (data) async* {
          yield TvShowDetailHasData(data);
        },
      );
    } else if (event is FetchedTvShowRecommendations) {
      yield TvShowRecommendationsLoading();
      final result = await _getTvShowRecommendations.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield TvShowRecommendationsError(failure.message);
        },
        (data) async* {
          yield TvShowRecommendationsHasData(data);
        },
      );
    } else if (event is FetchedTvShowWatchListStatus) {
      yield TvShowWatchlistStatusLoading();
      try {
        final result = await _getWatchListTvShowStatus.execute(event.id);
        yield TvShowWatchlistStatusHasData(result);
      } catch (error) {
        yield TvShowWatchlistStatusError(error.toString());
      }
    } else if (event is AddedWatchlistTvShow) {
      yield AddTvShowWatchlistLoading();
      final result = await _saveWatchlistTvShow.execute(event.tvShowDetail);

      yield* result.fold(
        (failure) async* {
          yield AddTvShowWatchlistError(failure.message);
        },
        (data) async* {
          yield AddTvShowWatchlistSuccess(data);
        },
      );
    } else if (event is RemovedWatchlistTvShow) {
      yield RemoveTvShowWatchlistLoading();
      final result = await _removeWatchlistTvShow.execute(event.tvShowDetail);

      yield* result.fold(
        (failure) async* {
          yield RemoveTvShowWatchlistError(failure.message);
        },
        (data) async* {
          yield RemoveTvShowWatchlistSuccess(data);
        },
      );
    }
  }
}
