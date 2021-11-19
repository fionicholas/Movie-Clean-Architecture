import 'package:about/about.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:core/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/list/movie_list_bloc.dart';
import 'package:core/presentation/bloc/movie/popular/popular_movie_bloc.dart';
import 'package:search/presentation/bloc/movie/search/search_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated/top_rated_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/tv_show/detail/tv_show_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_show/list/tv_show_list_bloc.dart';
import 'package:core/presentation/bloc/tv_show/popular/popular_tv_show_bloc.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_bloc.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/top_rated_tv_show_bloc.dart';
import 'package:core/presentation/bloc/tv_show/watchlist/watchlist_tv_show_bloc.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:core/presentation/pages/movie/movie_detail_page.dart';
import 'package:core/presentation/pages/movie/popular_movies_page.dart';
import 'package:core/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:core/presentation/pages/tv_show/popular_tv_shows_page.dart';
import 'package:core/presentation/pages/tv_show/top_rated_tv_shows_page.dart';
import 'package:core/presentation/pages/tv_show/tv_show_detail_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:core/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:core/utils/routes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvShowBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvShowDetailBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomePage(),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomePage());
            case popularMoviesRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedMoviesRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchRoute:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case tvShowDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                  builder: (_) => TvShowDetailPage(
                        id: id,
                      ));
            case popularTvShowsRoute:
              return MaterialPageRoute(builder: (_) => PopularTvShowsPage());
            case topRatedTvShowsRoute:
              return MaterialPageRoute(builder: (_) => TopRatedTvShowsPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
