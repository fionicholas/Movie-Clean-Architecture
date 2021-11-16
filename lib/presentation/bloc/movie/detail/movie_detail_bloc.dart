import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;
  final GetMovieRecommendations _getMovieRecommendations;
  final GetWatchListMovieStatus _getWatchListMovieStatus;
  final SaveWatchlistMovie _saveWatchlistMovie;
  final RemoveWatchlistMovie _removeWatchlistMovie;

  MovieDetailBloc(
      this._getMovieDetail,
      this._getMovieRecommendations,
      this._getWatchListMovieStatus,
      this._saveWatchlistMovie,
      this._removeWatchlistMovie)
      : super(MovieDetailEmpty());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is FetchedMovieDetail) {
      yield MovieDetailLoading();
      final result = await _getMovieDetail.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield MovieDetailError(failure.message);
        },
        (data) async* {
          yield MovieDetailHasData(data);
        },
      );
    } else if (event is FetchedMovieRecommendations) {
      yield MovieRecommendationsLoading();
      final result = await _getMovieRecommendations.execute(event.id);

      yield* result.fold(
        (failure) async* {
          yield MovieRecommendationsError(failure.message);
        },
        (data) async* {
          yield MovieRecommendationsHasData(data);
        },
      );
    } else if (event is FetchedWatchListStatus) {
      yield WatchlistStatusLoading();
      try {
        final result = await _getWatchListMovieStatus.execute(event.id);
        yield WatchlistStatusHasData(result);
      } catch (error) {
        yield WatchlistStatusError(error.toString());
      }
    } else if (event is AddedWatchlistMovie) {
      yield AddWatchlistLoading();
      final result = await _saveWatchlistMovie.execute(event.movieDetail);

      yield* result.fold(
        (failure) async* {
          yield AddWatchlistError(failure.message);
        },
        (data) async* {
          yield AddWatchlistSuccess(data);
        },
      );
    } else if (event is RemovedWatchlistMovie) {
      yield RemoveWatchlistLoading();
      final result = await _removeWatchlistMovie.execute(event.movieDetail);

      yield* result.fold(
        (failure) async* {
          yield RemoveWatchlistError(failure.message);
        },
        (data) async* {
          yield RemoveWatchlistSuccess(data);
        },
      );
    }
  }
}
