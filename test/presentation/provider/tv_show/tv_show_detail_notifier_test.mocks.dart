// Mocks generated by Mockito 5.0.8 from annotations
// in ditonton/test/presentation/provider/tv_show/tv_show_detail_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv_show.dart' as _i9;
import 'package:ditonton/domain/entities/tv_show_detail.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_show_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_detail.dart'
    as _i4;
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_recommendations.dart'
    as _i8;
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_status.dart'
    as _i10;
import 'package:ditonton/domain/usecases/tv_show/remove_watchlist.dart' as _i12;
import 'package:ditonton/domain/usecases/tv_show/save_watchlist.dart' as _i11;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeTvShowRepository extends _i1.Fake implements _i2.TvShowRepository {}

class _FakeEither<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetTvShowDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowDetail extends _i1.Mock implements _i4.GetTvShowDetail {
  MockGetTvShowDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>.value(
              _FakeEither<_i6.Failure, _i7.TvShowDetail>())) as _i5
          .Future<_i3.Either<_i6.Failure, _i7.TvShowDetail>>);
}

/// A class which mocks [GetTvShowRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvShowRecommendations extends _i1.Mock
    implements _i8.GetTvShowRecommendations {
  MockGetTvShowRecommendations() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>.value(
              _FakeEither<_i6.Failure, List<_i9.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i9.TvShow>>>);
}

/// A class which mocks [GetWatchListTvShowStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTvShowStatus extends _i1.Mock
    implements _i10.GetWatchListTvShowStatus {
  MockGetWatchListTvShowStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository()) as _i2.TvShowRepository);
  @override
  _i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
}

/// A class which mocks [SaveWatchlistTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistTvShow extends _i1.Mock
    implements _i11.SaveWatchlistTvShow {
  MockSaveWatchlistTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvShowDetail? tvShowDetail) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvShowDetail]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistTvShow].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistTvShow extends _i1.Mock
    implements _i12.RemoveWatchlistTvShow {
  MockRemoveWatchlistTvShow() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, String>> execute(
          _i7.TvShowDetail? tvShowDetail) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvShowDetail]),
              returnValue: Future<_i3.Either<_i6.Failure, String>>.value(
                  _FakeEither<_i6.Failure, String>()))
          as _i5.Future<_i3.Either<_i6.Failure, String>>);
}
