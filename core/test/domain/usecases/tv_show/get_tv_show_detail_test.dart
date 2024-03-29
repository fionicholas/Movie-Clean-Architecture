import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowDetail useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetTvShowDetail(mockTvShowRepository);
  });

  final tId = 1;

  test('should get tv show detail from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowDetail(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    // act
    final result = await useCase.execute(tId);
    // assert
    expect(result, Right(testTvShowDetail));
  });
}
