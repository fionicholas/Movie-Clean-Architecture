import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:core/domain/usecases/tv_show/get_watchlist_status.dart';
import 'package:core/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:core/domain/usecases/tv_show/save_watchlist.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_event.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchListTvShowStatus,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow
])
void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetWatchListTvShowStatus mockGetWatchListTvShowStatus;
  late MockSaveWatchlistTvShow mockSaveWatchlistTvShow;
  late MockRemoveWatchlistTvShow mockRemoveWatchlistTvShow;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchListTvShowStatus = MockGetWatchListTvShowStatus();
    mockSaveWatchlistTvShow = MockSaveWatchlistTvShow();
    mockRemoveWatchlistTvShow = MockRemoveWatchlistTvShow();
    tvShowDetailBloc = TvShowDetailBloc(
      mockGetTvShowDetail,
      mockGetTvShowRecommendations,
      mockGetWatchListTvShowStatus,
      mockSaveWatchlistTvShow,
      mockRemoveWatchlistTvShow,
    );
  });

  final testTvShow = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    voteAverage: 7.2,
    voteCount: 13507,
    originalName: 'Spider-Man',
    name: 'Spider-Man',
    firstAirDate: '2002-05-01',
  );

  final testTvShowList = [testTvShow];

  final tId = 1;

  final testTvShowDetail = TvShowDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
    numberOfSeasons: 1,
    numberOfEpisodes: 1,
  );

  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  group('TvShow detail', () {
    test('initial state should be empty', () {
      expect(tvShowDetailBloc.state, TvShowDetailEmpty());
    });

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvShowDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvShowDetail));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedTvShowDetail(tId)),
      expect: () => [
        TvShowDetailLoading(),
        TvShowDetailHasData(testTvShowDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvShowDetail.execute(tId));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTvShowDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedTvShowDetail(tId)),
      expect: () => [
        TvShowDetailLoading(),
        TvShowDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvShowDetail.execute(tId));
      },
    );
  });

  group('TvShow recommendations', () {
    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvShowRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvShowList));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedTvShowRecommendations(tId)),
      expect: () => [
        TvShowRecommendationsLoading(),
        TvShowRecommendationsHasData(testTvShowList),
      ],
      verify: (bloc) {
        verify(mockGetTvShowRecommendations.execute(tId));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetTvShowRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedTvShowRecommendations(tId)),
      expect: () => [
        TvShowRecommendationsLoading(),
        TvShowRecommendationsError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvShowRecommendations.execute(tId));
      },
    );
  });

  group('watch list TvShow status', () {
    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit Loading and HasData = true, when id exist in local database',
      build: () {
        when(mockGetWatchListTvShowStatus.execute(tId))
            .thenAnswer((_) async => true);
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedTvShowWatchListStatus(tId)),
      expect: () => [
        TvShowWatchlistStatusLoading(),
        TvShowWatchlistStatusHasData(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListTvShowStatus.execute(tId));
      },
    );
  });

  group('add TvShow watch list', () {
    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, Success] when add TvShow watch list is successful',
      build: () {
        when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
            .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(AddedWatchlistTvShow(testTvShowDetail)),
      expect: () => [
        AddTvShowWatchlistLoading(),
        AddTvShowWatchlistSuccess(watchlistAddSuccessMessage),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, Error] when add TvShow watch list is unsuccessful',
      build: () {
        when(mockSaveWatchlistTvShow.execute(testTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(AddedWatchlistTvShow(testTvShowDetail)),
      expect: () => [
        AddTvShowWatchlistLoading(),
        AddTvShowWatchlistError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTvShow.execute(testTvShowDetail));
      },
    );
  });

  group('remove TvShow watch list', () {
    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, Success] when remove TvShow watch list is successful',
      build: () {
        when(mockRemoveWatchlistTvShow.execute(testTvShowDetail))
            .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(RemovedWatchlistTvShow(testTvShowDetail)),
      expect: () => [
        RemoveTvShowWatchlistLoading(),
        RemoveTvShowWatchlistSuccess(watchlistRemoveSuccessMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
      },
    );

    blocTest<TvShowDetailBloc, TvShowDetailState>(
      'Should emit [Loading, Error] when remove TvShow watch list is unsuccessful',
      build: () {
        when(mockRemoveWatchlistTvShow.execute(testTvShowDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return tvShowDetailBloc;
      },
      act: (bloc) => bloc.add(RemovedWatchlistTvShow(testTvShowDetail)),
      expect: () => [
        RemoveTvShowWatchlistLoading(),
        RemoveTvShowWatchlistError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTvShow.execute(testTvShowDetail));
      },
    );
  });
}
