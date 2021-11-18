import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_event.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_state.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_event.dart';
import 'package:ditonton/presentation/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;

  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  @override
  void initState() {
    super.initState();
    context.read<MovieDetailBloc>().add(FetchedMovieDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MovieDetailBloc, MovieDetailState>(
              listener: (context, state) {
            if (state is AddWatchlistLoading) {
              showLoading(context);
            } else if (state is AddWatchlistSuccess) {
              hideLoading(context);
              _getWatchlistMovieStatus();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(watchlistAddSuccessMessage)));
            } else if (state is AddWatchlistError) {
              hideLoading(context);
              showToast(state.message);
            }
          }),
          BlocListener<MovieDetailBloc, MovieDetailState>(
              listener: (context, state) {
            if (state is RemoveWatchlistLoading) {
              showLoading(context);
            } else if (state is RemoveWatchlistSuccess) {
              hideLoading(context);
              _getWatchlistMovieStatus();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(watchlistRemoveSuccessMessage)));
            } else if (state is RemoveWatchlistError) {
              hideLoading(context);
              showToast(state.message);
            }
          }),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          buildWhen: (previousState, state) {
            return state is MovieDetailLoading ||
                state is MovieDetailHasData ||
                state is MovieDetailError;
          },
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailHasData) {
              final result = state.result;
              _getWatchlistMovieStatus();
              _getMovieRecommendations();
              return DetailContent(result);
            } else if (state is MovieDetailError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  void _getWatchlistMovieStatus() {
    context.read<MovieDetailBloc>().add(FetchedWatchListStatus(widget.id));
  }

  void _getMovieRecommendations() {
    context.read<MovieDetailBloc>().add(FetchedMovieRecommendations(widget.id));
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;

  DetailContent(this.movie);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        context.read<WatchlistMovieBloc>().add(FetchedWatchlistMovie());
        return true;
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: screenWidth,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            margin: const EdgeInsets.only(top: 48 + 8),
            child: DraggableScrollableSheet(
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 16,
                    right: 16,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      movie.title,
                                      style: kHeading5,
                                    ),
                                  ),
                                  BlocBuilder<MovieDetailBloc,
                                      MovieDetailState>(
                                    buildWhen: (previousState, state) {
                                      return state is WatchlistStatusLoading ||
                                          state is WatchlistStatusHasData ||
                                          state is WatchlistStatusError;
                                    },
                                    builder: (context, state) {
                                      if (state is WatchlistStatusLoading) {
                                        return ElevatedButton(
                                            onPressed: () {},
                                            child: CircularProgressIndicator());
                                      } else if (state
                                          is WatchlistStatusHasData) {
                                        final isAddedWatchlist = state.result;
                                        return ElevatedButton(
                                          onPressed: () async {
                                            if (!isAddedWatchlist) {
                                              context
                                                  .read<MovieDetailBloc>()
                                                  .add(AddedWatchlistMovie(
                                                      movie));
                                            } else {
                                              context
                                                  .read<MovieDetailBloc>()
                                                  .add(RemovedWatchlistMovie(
                                                      movie));
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              isAddedWatchlist
                                                  ? Icon(Icons.check)
                                                  : Icon(Icons.add),
                                              Text('Watchlist'),
                                            ],
                                          ),
                                        );
                                      } else if (state
                                          is WatchlistStatusError) {
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
                              Text(
                                _showGenres(movie.genres),
                              ),
                              Text(
                                _showDuration(movie.runtime),
                              ),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: movie.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${movie.voteAverage}')
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                movie.overview,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              BlocBuilder<MovieDetailBloc, MovieDetailState>(
                                buildWhen: (previousState, state) {
                                  return state is MovieRecommendationsLoading ||
                                      state is MovieRecommendationsHasData ||
                                      state is MovieRecommendationsError;
                                },
                                builder: (context, state) {
                                  if (state is MovieRecommendationsLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is MovieRecommendationsHasData) {
                                    final recommendations = state.result;
                                    return Container(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final movie = recommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  MovieDetailPage.ROUTE_NAME,
                                                  arguments: movie.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                  placeholder: (context, url) =>
                                                      Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: recommendations.length,
                                      ),
                                    );
                                  } else if (state
                                      is MovieRecommendationsError) {
                                    return Center(
                                      child: Text(state.message),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Colors.white,
                          height: 4,
                          width: 48,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // initialChildSize: 0.5,
              minChildSize: 0.25,
              // maxChildSize: 1.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
