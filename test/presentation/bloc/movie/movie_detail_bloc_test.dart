import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListMovieStatus,
  SaveWatchlistMovie,
  RemoveWatchlistMovie
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListMovieStatus mockGetWatchListMovieStatus;
  late MockSaveWatchlistMovie mockSaveWatchlistMovie;
  late MockRemoveWatchlistMovie mockRemoveWatchlistMovie;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListMovieStatus = MockGetWatchListMovieStatus();
    mockSaveWatchlistMovie = MockSaveWatchlistMovie();
    mockRemoveWatchlistMovie = MockRemoveWatchlistMovie();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchListMovieStatus,
      mockSaveWatchlistMovie,
      mockRemoveWatchlistMovie,
    );
  });

  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieList = [testMovie];

  final tId = 1;

  final testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  group('movie detail', () {
    test('initial state should be empty', () {
      expect(movieDetailBloc.state, MovieDetailEmpty());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedMovieDetail(tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('movie recommendations', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedMovieRecommendations(tId)),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get data is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedMovieRecommendations(tId)),
      expect: () => [
        MovieRecommendationsLoading(),
        MovieRecommendationsError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('watch list movie status', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit Loading and HasData = true, when id exist in local database',
      build: () {
        when(mockGetWatchListMovieStatus.execute(tId))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(FetchedWatchListStatus(tId)),
      expect: () => [
        WatchlistStatusLoading(),
        WatchlistStatusHasData(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListMovieStatus.execute(tId));
      },
    );
  });

  group('add movie watch list', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Success] when add movie watch list is successful',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddedWatchlistMovie(testMovieDetail)),
      expect: () => [
        AddWatchlistLoading(),
        AddWatchlistSuccess(watchlistAddSuccessMessage),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when add movie watch list is unsuccessful',
      build: () {
        when(mockSaveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddedWatchlistMovie(testMovieDetail)),
      expect: () => [
        AddWatchlistLoading(),
        AddWatchlistError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistMovie.execute(testMovieDetail));
      },
    );
  });

  group('remove movie watch list', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Success] when remove movie watch list is successful',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemovedWatchlistMovie(testMovieDetail)),
      expect: () => [
        RemoveWatchlistLoading(),
        RemoveWatchlistSuccess(watchlistRemoveSuccessMessage),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when remove movie watch list is unsuccessful',
      build: () {
        when(mockRemoveWatchlistMovie.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemovedWatchlistMovie(testMovieDetail)),
      expect: () => [
        RemoveWatchlistLoading(),
        RemoveWatchlistError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
      },
    );
  });
}
