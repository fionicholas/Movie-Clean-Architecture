import 'package:core/utils/exception.dart';
import 'package:core/data/models/watch_list_tv_show_table.dart';

import 'db/database_helper.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertWatchlist(WatchListTvShowTable watchList);

  Future<String> removeWatchlist(WatchListTvShowTable watchList);

  Future<WatchListTvShowTable?> getTvShowWatchListById(int id);

  Future<List<WatchListTvShowTable>> getWatchlistTvShows();
}

class TvShowLocalDataSourceImpl implements TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchListTvShowTable watchList) async {
    try {
      await databaseHelper.insertTvShowWatchlist(watchList);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchListTvShowTable watchList) async {
    try {
      await databaseHelper.removeTvShowWatchlist(watchList);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchListTvShowTable?> getTvShowWatchListById(int id) async {
    final result = await databaseHelper.getTvShowWatchListById(id);
    if (result != null) {
      return WatchListTvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<WatchListTvShowTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => WatchListTvShowTable.fromMap(data)).toList();
  }
}
