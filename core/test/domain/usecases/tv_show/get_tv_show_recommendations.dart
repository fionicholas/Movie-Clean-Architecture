import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTvShowRecommendations(mockTvShowRepository);
  });

  final tId = 1;
  final tvShow = <TvShow>[];

  test('should get list of tv show recommendations from the repository',
          () async {
        // arrange
        when(mockTvShowRepository.getTvShowRecommendations(tId))
            .thenAnswer((_) async => Right(tvShow));
        // act
        final result = await useCase.execute(tId);
        // assert
        expect(result, Right(tvShow));
      });
}
