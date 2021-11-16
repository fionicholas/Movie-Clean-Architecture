import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:ditonton/presentation/bloc/tv_show/popular/popular_tv_show_event.dart';
import 'package:ditonton/presentation/bloc/tv_show/popular/popular_tv_show_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvShowBloc extends Bloc<PopularTvShowEvent, PopularTvShowState> {
  final GetPopularTvShows _getPopularTvShows;

  PopularTvShowBloc(this._getPopularTvShows) : super(PopularTvShowEmpty());

  @override
  Stream<PopularTvShowState> mapEventToState(
      PopularTvShowEvent event,
      ) async* {
    if (event is FetchedPopularTvShow) {
      yield PopularTvShowLoading();
      final result = await _getPopularTvShows.execute();

      yield* result.fold(
            (failure) async* {
          yield PopularTvShowError(failure.message);
        },
            (data) async* {
          yield PopularTvShowHasData(data);
        },
      );
    }
  }
}