import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/bloc/tv_show/top_rated/top_rated_tv_show_event.dart';
import 'package:ditonton/presentation/bloc/tv_show/top_rated/top_rated_tv_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTvShowBloc extends Bloc<TopRatedTvShowEvent, TopRatedTvShowState> {
  final GetTopRatedTvShows _getTopRatedTvShow;

  TopRatedTvShowBloc(this._getTopRatedTvShow) : super(TopRatedTvShowEmpty());

  @override
  Stream<TopRatedTvShowState> mapEventToState(
      TopRatedTvShowEvent event,
      ) async* {
    if (event is FetchedTopRatedTvShow) {
      yield TopRatedTvShowLoading();
      final result = await _getTopRatedTvShow.execute();

      yield* result.fold(
            (failure) async* {
          yield TopRatedTvShowError(failure.message);
        },
            (data) async* {
          yield TopRatedTvShowHasData(data);
        },
      );
    }
  }
}