import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv_show.dart';
import 'package:core/presentation/bloc/movie/list/movie_list_bloc.dart';
import 'package:core/presentation/bloc/movie/list/movie_list_event.dart';
import 'package:core/presentation/bloc/movie/list/movie_list_state.dart';
import 'package:core/presentation/bloc/tv_show/list/tv_show_list_bloc.dart';
import 'package:core/presentation/bloc/tv_show/list/tv_show_list_event.dart';
import 'package:core/presentation/bloc/tv_show/list/tv_show_list_state.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieListBloc>().add(FetchedPopularMovie());
      context.read<MovieListBloc>().add(FetchedTopRatedMovie());
      context.read<MovieListBloc>().add(FetchedNowPlayingMovie());

      context.read<TvShowListBloc>().add(FetchedPopularTvShowList());
      context.read<TvShowListBloc>().add(FetchedTopRatedTvShowList());
      context.read<TvShowListBloc>().add(FetchedNowPlayingTvShowList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, watchlistRoute);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, aboutRoute);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, searchRoute);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movie - Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                buildWhen: (previousState, state) {
                  return state is NowPlayingMovieLoading ||
                      state is NowPlayingMovieHasData ||
                      state is NowPlayingMovieError;
                },
                builder: (context, state) {
                  if (state is NowPlayingMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingMovieHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is NowPlayingMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Movie - Popular',
                onTap: () =>
                    Navigator.pushNamed(context, popularMoviesRoute),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                buildWhen: (previousState, state) {
                  return state is PopularMovieLoading ||
                      state is PopularMovieHasData ||
                      state is PopularMovieError;
                },
                builder: (context, state) {
                  if (state is PopularMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMovieHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is PopularMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Movie - Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, topRatedMoviesRoute),
              ),
              BlocBuilder<MovieListBloc, MovieListState>(
                buildWhen: (previousState, state) {
                  return state is TopRatedMovieLoading ||
                      state is TopRatedMovieHasData ||
                      state is TopRatedMovieError;
                },
                builder: (context, state) {
                  if (state is TopRatedMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMovieHasData) {
                    final result = state.result;
                    return MovieList(result);
                  } else if (state is TopRatedMovieError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Text(
                'Tv Show - Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<TvShowListBloc, TvShowListState>(
                buildWhen: (previousState, state) {
                  return state is NowPlayingTvShowListLoading ||
                      state is NowPlayingTvShowListHasData ||
                      state is NowPlayingTvShowListError;
                },
                builder: (context, state) {
                  if (state is NowPlayingTvShowListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTvShowListHasData) {
                    final result = state.result;
                    return TvShowList(result);
                  } else if (state is NowPlayingTvShowListError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Tv Show - Popular',
                onTap: () =>
                    Navigator.pushNamed(context, popularTvShowsRoute),
              ),
              BlocBuilder<TvShowListBloc, TvShowListState>(
                buildWhen: (previousState, state) {
                  return state is PopularTvShowListLoading ||
                      state is PopularTvShowListHasData ||
                      state is PopularTvShowListError;
                },
                builder: (context, state) {
                  if (state is PopularTvShowListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvShowListHasData) {
                    final result = state.result;
                    return TvShowList(result);
                  } else if (state is PopularTvShowListError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Tv Show - Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, topRatedTvShowsRoute),
              ),
              BlocBuilder<TvShowListBloc, TvShowListState>(
                buildWhen: (previousState, state) {
                  return state is TopRatedTvShowListLoading ||
                      state is TopRatedTvShowListHasData ||
                      state is TopRatedTvShowListError;
                },
                builder: (context, state) {
                  if (state is TopRatedTvShowListLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTvShowListHasData) {
                    final result = state.result;
                    return TvShowList(result);
                  } else if (state is TopRatedTvShowListError) {
                    return Center(
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  movieDetailRoute,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvShow = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvShowDetailRoute,
                  arguments: tvShow.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvShow.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
