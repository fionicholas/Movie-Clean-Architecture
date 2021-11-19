import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv_shows.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_bloc.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_event.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_state.dart';

import 'search_tv_show_bloc_test.mocks.dart';


@GenerateMocks([SearchTvShows])
void main() {
  late SearchTvShowBloc searchBloc;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    searchBloc = SearchTvShowBloc(mockSearchTvShows);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchTvShowEmpty());
  });

  final tvShowModel = TvShow(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
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
  final tvShowList = <TvShow>[tvShowModel];
  const tQuery = 'spiderman';

  blocTest<SearchTvShowBloc, SearchTvShowState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tvShowList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvShowChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvShowLoading(),
      SearchTvShowHasData(tvShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );

  blocTest<SearchTvShowBloc, SearchTvShowState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryTvShowChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvShowLoading(),
      SearchTvShowError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );
}
