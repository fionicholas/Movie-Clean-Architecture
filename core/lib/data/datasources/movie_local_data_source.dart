import 'package:core/data/models/watch_list_movie_table.dart';
import 'package:core/utils/exception.dart';

import 'db/database_helper.dart';

abstract class MovieLocalDataSource {
  Future<String> insertWatchlist(WatchListMovieTable movie);
  Future<String> removeWatchlist(WatchListMovieTable movie);
  Future<WatchListMovieTable?> getMovieById(int id);
  Future<List<WatchListMovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchListMovieTable movie) async {
    try {
      await databaseHelper.insertMovieWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchListMovieTable movie) async {
    try {
      await databaseHelper.removeMovieWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchListMovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieWatchListById(id);
    if (result != null) {
      return WatchListMovieTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchListMovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => WatchListMovieTable.fromMap(data)).toList();
  }
}
