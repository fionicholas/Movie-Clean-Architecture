
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/presentation/bloc/movie/search/search_movie_event.dart';
import 'package:search/presentation/bloc/movie/search/search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchEmpty());

  @override
  Stream<Transition<SearchMovieEvent, SearchMovieState>> transformEvents(
      Stream<SearchMovieEvent> events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap((transitionFn));
  }

  @override
  Stream<SearchMovieState> mapEventToState(
    SearchMovieEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchLoading();
      final result = await _searchMovies.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchError(failure.message);
        },
        (data) async* {
          yield SearchHasData(data);
        },
      );
    }
  }
}
