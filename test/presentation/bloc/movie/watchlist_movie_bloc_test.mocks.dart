// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/bloc/movie/watchlist_movie_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/common/failure.dart' as _i5;
import 'package:ditonton/domain/entities/movie.dart' as _i6;
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends _i1.Mock
    implements _i3.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>.value(
              _FakeEither<_i5.Failure, List<_i6.Movie>>())) as _i4
          .Future<_i2.Either<_i5.Failure, List<_i6.Movie>>>);
}