import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvShows useCase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    useCase = GetNowPlayingTvShows(mockTvShowRepository);
  });

  final tvShow = <TvShow>[];

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.getNowPlayingTvShows())
        .thenAnswer((_) async => Right(tvShow));
    // act
    final result = await useCase.execute();
    // assert
    expect(result, Right(tvShow));
  });
}
