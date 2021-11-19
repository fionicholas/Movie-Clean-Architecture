
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:core/presentation/bloc/tv_show/popular/popular_tv_show_bloc.dart';
import 'package:core/presentation/bloc/tv_show/popular/popular_tv_show_event.dart';
import 'package:core/presentation/bloc/tv_show/popular/popular_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_show_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late PopularTvShowBloc popularTvShowBloc;
  late MockGetPopularTvShows mockGetPopularTvShows;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowBloc = PopularTvShowBloc(mockGetPopularTvShows);
  });

  test('initial state should be empty', () {
    expect(popularTvShowBloc.state, PopularTvShowEmpty());
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

  blocTest<PopularTvShowBloc, PopularTvShowState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return popularTvShowBloc;
    },
    act: (bloc) => bloc.add(FetchedPopularTvShow()),
    expect: () => [
      PopularTvShowLoading(),
      PopularTvShowHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );

  blocTest<PopularTvShowBloc, PopularTvShowState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvShowBloc;
    },
    act: (bloc) => bloc.add(FetchedPopularTvShow()),
    expect: () => [
      PopularTvShowLoading(),
      PopularTvShowError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );
}