import 'package:ditonton/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/list/movie_list_event.dart';
import 'package:ditonton/presentation/bloc/movie/list/movie_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  MovieListBloc(
    this._getPopularMovies,
    this._getNowPlayingMovies,
    this._getTopRatedMovies,
  ) : super(MovieListEmpty());

  @override
  Stream<MovieListState> mapEventToState(
    MovieListEvent event,
  ) async* {
    if (event is FetchedNowPlayingMovie) {
      yield NowPlayingMovieLoading();
      final result = await _getNowPlayingMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield NowPlayingMovieError(failure.message);
        },
        (data) async* {
          yield NowPlayingMovieHasData(data);
        },
      );
    } else if (event is FetchedPopularMovie) {
      yield PopularMovieLoading();
      final result = await _getPopularMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield PopularMovieError(failure.message);
        },
        (data) async* {
          yield PopularMovieHasData(data);
        },
      );
    } else if (event is FetchedTopRatedMovie) {
      yield TopRatedMovieLoading();
      final result = await _getTopRatedMovies.execute();

      yield* result.fold(
        (failure) async* {
          yield TopRatedMovieError(failure.message);
        },
        (data) async* {
          yield TopRatedMovieHasData(data);
        },
      );
    }
  }
}
