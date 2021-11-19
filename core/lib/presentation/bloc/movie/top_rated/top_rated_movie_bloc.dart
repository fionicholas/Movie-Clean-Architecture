import 'package:core/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie/top_rated/top_rated_movie_event.dart';
import 'package:core/presentation/bloc/movie/top_rated/top_rated_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovie;

  TopRatedMovieBloc(this._getTopRatedMovie) : super(TopRatedMovieEmpty());

  @override
  Stream<TopRatedMovieState> mapEventToState(
    TopRatedMovieEvent event,
  ) async* {
    if (event is FetchedTopRatedMovie) {
      yield TopRatedMovieLoading();
      final result = await _getTopRatedMovie.execute();

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
