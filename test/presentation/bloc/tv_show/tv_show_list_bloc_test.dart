import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/bloc/tv_show/list/tv_show_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/list/tv_show_list_event.dart';
import 'package:ditonton/presentation/bloc/tv_show/list/tv_show_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_list_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows, GetPopularTvShows, GetTopRatedTvShows])
void main() {
  late TvShowListBloc tvShowListBloc;
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;
  late MockGetPopularTvShows mockGetPopularTvShows;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    mockGetPopularTvShows = MockGetPopularTvShows();
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    tvShowListBloc = TvShowListBloc(mockGetPopularTvShows,
        mockGetNowPlayingTvShows, mockGetTopRatedTvShows);
  });

  final tvShowModel = TvShow(
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
  final tTvShowList = <TvShow>[tvShowModel];

  group('now playing TvShows', () {
    test('initial state should be empty', () {
      expect(tvShowListBloc.state, TvShowListEmpty());
    });

    blocTest<TvShowListBloc, TvShowListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return tvShowListBloc;
      },
      act: (bloc) => bloc.add(FetchedNowPlayingTvShowList()),
      expect: () => [
        NowPlayingTvShowListLoading(),
        NowPlayingTvShowListHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvShows.execute());
      },
    );

    blocTest<TvShowListBloc, TvShowListState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetNowPlayingTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvShowListBloc;
      },
      act: (bloc) => bloc.add(FetchedNowPlayingTvShowList()),
      expect: () => [
        NowPlayingTvShowListLoading(),
        NowPlayingTvShowListError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTvShows.execute());
      },
    );
  });

  group('popular TvShows', () {
    test('initial state should be empty', () {
      expect(tvShowListBloc.state, TvShowListEmpty());
    });

    blocTest<TvShowListBloc, TvShowListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return tvShowListBloc;
      },
      act: (bloc) => bloc.add(FetchedPopularTvShowList()),
      expect: () => [
        PopularTvShowListLoading(),
        PopularTvShowListHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
      },
    );

    blocTest<TvShowListBloc, TvShowListState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetPopularTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvShowListBloc;
      },
      act: (bloc) => bloc.add(FetchedPopularTvShowList()),
      expect: () => [
        PopularTvShowListLoading(),
        PopularTvShowListError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTvShows.execute());
      },
    );
  });

  group('top rated TvShows', () {
    test('initial state should be empty', () {
      expect(tvShowListBloc.state, TvShowListEmpty());
    });

    blocTest<TvShowListBloc, TvShowListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Right(tTvShowList));
        return tvShowListBloc;
      },
      act: (bloc) => bloc.add(FetchedTopRatedTvShowList()),
      expect: () => [
        TopRatedTvShowListLoading(),
        TopRatedTvShowListHasData(tTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );

    blocTest<TvShowListBloc, TvShowListState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTopRatedTvShows.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvShowListBloc;
      },
      act: (bloc) => bloc.add(FetchedTopRatedTvShowList()),
      expect: () => [
        TopRatedTvShowListLoading(),
        TopRatedTvShowListError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTvShows.execute());
      },
    );
  });
}
