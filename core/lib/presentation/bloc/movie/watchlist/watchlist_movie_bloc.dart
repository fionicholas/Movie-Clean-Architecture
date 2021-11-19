import 'package:core/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:core/presentation/bloc/movie/watchlist/watchlist_movie_event.dart';
import 'package:core/presentation/bloc/movie/watchlist/watchlist_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovie;

  WatchlistMovieBloc(this._getWatchlistMovie) : super(WatchlistMovieEmpty());

  @override
  Stream<WatchlistMovieState> mapEventToState(
    WatchlistMovieEvent event,
  ) async* {
    if (event is FetchedWatchlistMovie) {
      yield WatchlistMovieLoading();
      final result = await _getWatchlistMovie.execute();

      yield* result.fold(
        (failure) async* {
          yield WatchlistMovieError(failure.message);
        },
        (data) async* {
          yield WatchlistMovieHasData(data);
        },
      );
    }
  }
}
