import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:ditonton/presentation/bloc/tv_show/watchlist/watchlist_tv_show_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/watchlist/watchlist_tv_show_event.dart';
import 'package:ditonton/presentation/bloc/tv_show/watchlist/watchlist_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_show_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvShowBloc watchlistTvShowBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    watchlistTvShowBloc = WatchlistTvShowBloc(mockGetWatchlistTvShows);
  });

  test('initial state should be empty', () {
    expect(watchlistTvShowBloc.state, WatchlistTvShowEmpty());
  });

  final tTvShowModel = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview:
    'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tTvShowList = <TvShow>[tTvShowModel];

  blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return watchlistTvShowBloc;
    },
    act: (bloc) => bloc.add(FetchedWatchlistTvShow()),
    expect: () => [
      WatchlistTvShowLoading(),
      WatchlistTvShowHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );

  blocTest<WatchlistTvShowBloc, WatchlistTvShowState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvShowBloc;
    },
    act: (bloc) => bloc.add(FetchedWatchlistTvShow()),
    expect: () => [
      WatchlistTvShowLoading(),
      WatchlistTvShowError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );
}