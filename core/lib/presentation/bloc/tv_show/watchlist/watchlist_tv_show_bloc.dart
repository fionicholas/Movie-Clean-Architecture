import 'package:core/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:core/presentation/bloc/tv_show/watchlist/watchlist_tv_show_event.dart';
import 'package:core/presentation/bloc/tv_show/watchlist/watchlist_tv_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvShowBloc
    extends Bloc<WatchlistTvShowEvent, WatchlistTvShowState> {
  final GetWatchlistTvShows _getWatchlistTvShow;

  WatchlistTvShowBloc(this._getWatchlistTvShow) : super(WatchlistTvShowEmpty());

  @override
  Stream<WatchlistTvShowState> mapEventToState(
    WatchlistTvShowEvent event,
  ) async* {
    if (event is FetchedWatchlistTvShow) {
      yield WatchlistTvShowLoading();
      final result = await _getWatchlistTvShow.execute();

      yield* result.fold(
        (failure) async* {
          yield WatchlistTvShowError(failure.message);
        },
        (data) async* {
          yield WatchlistTvShowHasData(data);
        },
      );
    }
  }
}
