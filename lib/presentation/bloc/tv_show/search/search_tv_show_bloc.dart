import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/tv_show/search/search_tv_show_event.dart';
import 'package:ditonton/presentation/bloc/tv_show/search/search_tv_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchTvShowBloc extends Bloc<SearchTvShowEvent, SearchTvShowState> {
  final SearchTvShows _searchTvShows;

  SearchTvShowBloc(this._searchTvShows) : super(SearchEmpty());

  @override
  Stream<Transition<SearchTvShowEvent, SearchTvShowState>> transformEvents(
      Stream<SearchTvShowEvent> events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap((transitionFn));
  }

  @override
  Stream<SearchTvShowState> mapEventToState(
    SearchTvShowEvent event,
  ) async* {
    if (event is OnQueryChanged) {
      final query = event.query;

      yield SearchLoading();
      final result = await _searchTvShows.execute(query);

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
