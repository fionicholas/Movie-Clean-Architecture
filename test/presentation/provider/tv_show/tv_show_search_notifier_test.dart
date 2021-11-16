import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late TvShowSearchNotifier provider;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTvShows = MockSearchTvShows();
    provider = TvShowSearchNotifier(searchTvShows: mockSearchTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tvShowModel = TvShow(
    backdropPath: '/4QNBIgt5fwgNCN3OSU6BTFv0NGR.jpg',
    genreIds: [16, 10759],
    id: 888,
    originalName: 'Spider-Man',
    overview:
    'Bitten by a radioactive spider, Peter Parker develops spider-like superpowers. He uses these to fight crime while trying to balance it with the struggles of his personal life.',
    popularity: 85.804,
    posterPath: '/wXthtEN5kdWA1bHz03lkuCJS6hA.jpg',
    firstAirDate: '1994-11-19',
    name: 'Spider-Man',
    voteAverage: 8.3,
    voteCount: 637,
  );
  final tvShowList = <TvShow>[tvShowModel];
  final tQuery = 'spiderman';

  group('search tv shows', () {
    test('should change state to loading when use case is called', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tvShowList));
      // act
      provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tvShowList));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
