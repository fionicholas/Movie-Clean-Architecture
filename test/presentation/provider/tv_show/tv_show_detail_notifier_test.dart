
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show/save_watchlist.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetWatchListTvShowStatus,
  SaveWatchlistTvShow,
  RemoveWatchlistTvShow,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetWatchListTvShowStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTvShow mockSaveWatchlist;
  late MockRemoveWatchlistTvShow mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistStatus = MockGetWatchListTvShowStatus();
    mockSaveWatchlist = MockSaveWatchlistTvShow();
    mockRemoveWatchlist = MockRemoveWatchlistTvShow();
    provider = TvShowDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tId = 1;

  final tvShow = TvShow(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tvShows = <TvShow>[tvShow];

  void _arrangeUseCase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvShowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tvShows));
  }

  group('Get Tv show Detail', () {
    test('should get data from the use case', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    });

    test('should change state to Loading when use case is called', () {
      // arrange
      _arrangeUseCase();
      // act
      provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv shows when data is gotten successfully',
            () async {
          // arrange
          _arrangeUseCase();
          // act
          await provider.fetchTvShowDetail(tId);
          // assert
          expect(provider.tvShowState, RequestState.Loaded);
          expect(provider.tvShowRecommendations, tvShows);
        });
  });

  group('Get Tv Show Recommendations', () {
    test('should get data from the use case', () async {
      // arrange
      _arrangeUseCase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowRecommendations.execute(tId));
      expect(provider.tvShowRecommendations, tvShows);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUseCase();
          // act
          await provider.fetchTvShowDetail(tId);
          // assert
          expect(provider.recommendationState, RequestState.Loaded);
          expect(provider.tvShowRecommendations, tvShows);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvShowDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockGetWatchlistStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tvShows));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}