import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_local_data_source.dart';
import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';
import 'package:ditonton/domain/usecases/movie/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/movie/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie/search_movies.dart';
import 'package:ditonton/domain/usecases/tv_show/get_now_playing_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_popular_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_top_rated_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/tv_show/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv_show/get_watchlist_tv_shows.dart';
import 'package:ditonton/domain/usecases/tv_show/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show/save_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_show/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/list/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/search/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/detail/tv_show_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/list/tv_show_list_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/popular/popular_tv_show_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/search/search_tv_show_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/top_rated/top_rated_tv_show_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/watchlist/watchlist_tv_show_bloc.dart';
import 'package:ditonton/presentation/provider/movie/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/movie/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/movie/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/popular_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/top_rated_tv_shows_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/tv_show_search_notifier.dart';
import 'package:ditonton/presentation/provider/tv_show/watchlist_tv_show_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'domain/usecases/movie/get_movie_recommendations.dart';
import 'domain/usecases/movie/get_now_playing_movies.dart';
import 'domain/usecases/movie/get_popular_movies.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // tv show
  locator.registerFactory(
    () => TvShowListNotifier(
      getNowPlayingTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowSearchNotifier(
      searchTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowsNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsNotifier(
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvShowNotifier(
      getWatchlistTvShows: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListMovieStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistMovie(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchListTvShowStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTvShow(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());

  // bloc
  locator.registerFactory(
    () => SearchMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieListBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
        () => SearchTvShowBloc(
      locator(),
    ),
  );

  locator.registerFactory(
        () => PopularTvShowBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedTvShowBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistTvShowBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvShowDetailBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
        () => TvShowListBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
}
