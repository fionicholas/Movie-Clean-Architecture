import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShows useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetPopularTvShows(mockTvShowRepository);
  });

  final tvShows = <TvShow>[];

  group('Get Popular Tv Shows Tests', () {
    group('execute', () {
      test(
          'should get list of tv shows from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvShowRepository.getPopularTvShows())
                .thenAnswer((_) async => Right(tvShows));
            // act
            final result = await useCase.execute();
            // assert
            expect(result, Right(tvShows));
          });
    });
  });
}
