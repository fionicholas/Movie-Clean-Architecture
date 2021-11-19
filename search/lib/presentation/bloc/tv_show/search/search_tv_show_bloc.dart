import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_event.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_state.dart';

class SearchTvShowBloc extends Bloc<SearchTvShowEvent, SearchTvShowState> {
  final SearchTvShows _searchTvShows;

  SearchTvShowBloc(this._searchTvShows) : super(SearchTvShowEmpty());

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
    if (event is OnQueryTvShowChanged) {
      final query = event.query;

      yield SearchTvShowLoading();
      final result = await _searchTvShows.execute(query);

      yield* result.fold(
        (failure) async* {
          yield SearchTvShowError(failure.message);
        },
        (data) async* {
          yield SearchTvShowHasData(data);
        },
      );
    }
  }
}
