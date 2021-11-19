import 'package:core/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:core/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:core/presentation/bloc/tv_show/list/tv_show_list_event.dart';
import 'package:core/presentation/bloc/tv_show/list/tv_show_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvShowListBloc extends Bloc<TvShowListEvent, TvShowListState> {
  final GetNowPlayingTvShows _getNowPlayingTvShows;
  final GetPopularTvShows _getPopularTvShows;
  final GetTopRatedTvShows _getTopRatedTvShows;

  TvShowListBloc(
    this._getPopularTvShows,
    this._getNowPlayingTvShows,
    this._getTopRatedTvShows,
  ) : super(TvShowListEmpty());

  @override
  Stream<TvShowListState> mapEventToState(
    TvShowListEvent event,
  ) async* {
    if (event is FetchedNowPlayingTvShowList) {
      yield NowPlayingTvShowListLoading();
      final result = await _getNowPlayingTvShows.execute();

      yield* result.fold(
        (failure) async* {
          yield NowPlayingTvShowListError(failure.message);
        },
        (data) async* {
          yield NowPlayingTvShowListHasData(data);
        },
      );
    } else if (event is FetchedPopularTvShowList) {
      yield PopularTvShowListLoading();
      final result = await _getPopularTvShows.execute();

      yield* result.fold(
        (failure) async* {
          yield PopularTvShowListError(failure.message);
        },
        (data) async* {
          yield PopularTvShowListHasData(data);
        },
      );
    } else if (event is FetchedTopRatedTvShowList) {
      yield TopRatedTvShowListLoading();
      final result = await _getTopRatedTvShows.execute();

      yield* result.fold(
        (failure) async* {
          yield TopRatedTvShowListError(failure.message);
        },
        (data) async* {
          yield TopRatedTvShowListHasData(data);
        },
      );
    }
  }
}
