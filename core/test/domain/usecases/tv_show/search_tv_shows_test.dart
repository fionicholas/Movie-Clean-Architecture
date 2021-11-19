import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = SearchTvShows(mockTvShowRepository);
  });

  final tvShows = <TvShow>[];
  final tQuery = 'Spiderman';

  test('should get list of tv show from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShows(tQuery))
        .thenAnswer((_) async => Right(tvShows));
    // act
    final result = await useCase.execute(tQuery);
    // assert
    expect(result, Right(tvShows));
  });
}