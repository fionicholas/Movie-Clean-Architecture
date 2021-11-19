import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvShows();
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
  Future<Either<Failure, String>> saveWatchlist(TvShowDetail movie);
  Future<Either<Failure, String>> removeWatchlist(TvShowDetail movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}