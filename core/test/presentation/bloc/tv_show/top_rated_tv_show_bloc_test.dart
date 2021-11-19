import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/top_rated_tv_show_bloc.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/top_rated_tv_show_event.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/top_rated_tv_show_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_show_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late TopRatedTvShowBloc topRatedTvShowBloc;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    topRatedTvShowBloc = TopRatedTvShowBloc(mockGetTopRatedTvShows);
  });

  test('initial state should be empty', () {
    expect(topRatedTvShowBloc.state, TopRatedTvShowEmpty());
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

  blocTest<TopRatedTvShowBloc, TopRatedTvShowState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(tTvShowList));
      return topRatedTvShowBloc;
    },
    act: (bloc) => bloc.add(FetchedTopRatedTvShow()),
    expect: () => [
      TopRatedTvShowLoading(),
      TopRatedTvShowHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TopRatedTvShowBloc, TopRatedTvShowState>(
    'Should emit [Loading, Error] when get data is unsuccessful',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedTvShowBloc;
    },
    act: (bloc) => bloc.add(FetchedTopRatedTvShow()),
    expect: () => [
      TopRatedTvShowLoading(),
      TopRatedTvShowError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );
}
