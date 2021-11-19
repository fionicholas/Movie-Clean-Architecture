import 'package:core/domain/usecases/movie/get_popular_movies.dart';
import 'package:core/presentation/bloc/movie/popular/popular_movie_event.dart';
import 'package:core/presentation/bloc/movie/popular/popular_movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieEmpty());

  @override
  Stream<PopularMovieState> mapEventToState(
    PopularMovieEvent event,
  ) async* {
    if (event is FetchedPopularMovie) {
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
    }
  }
}
