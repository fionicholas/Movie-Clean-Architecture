import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/presentation/bloc/tv_show/detail/tv_show_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/detail/tv_show_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_show/detail/tv_show_detail_state.dart';
import 'package:ditonton/presentation/bloc/tv_show/watchlist/watchlist_tv_show_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/watchlist/watchlist_tv_show_event.dart';
import 'package:ditonton/presentation/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvShowDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_show_detail';

  final int id;

  TvShowDetailPage({required this.id});

  @override
  _TvShowDetailPageState createState() => _TvShowDetailPageState();
}

class _TvShowDetailPageState extends State<TvShowDetailPage> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  @override
  void initState() {
    super.initState();
    context.read<TvShowDetailBloc>().add(FetchedTvShowDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<TvShowDetailBloc, TvShowDetailState>(
              listener: (context, state) {
            if (state is AddTvShowWatchlistLoading) {
              showLoading(context);
            } else if (state is AddTvShowWatchlistSuccess) {
              hideLoading(context);
              _getWatchlistTvShowStatus();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(watchlistAddSuccessMessage)));
            } else if (state is AddTvShowWatchlistError) {
              hideLoading(context);
              showToast(state.message);
            }
          }),
          BlocListener<TvShowDetailBloc, TvShowDetailState>(
              listener: (context, state) {
            if (state is RemoveTvShowWatchlistLoading) {
              showLoading(context);
            } else if (state is RemoveTvShowWatchlistSuccess) {
              hideLoading(context);
              _getWatchlistTvShowStatus();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(watchlistRemoveSuccessMessage)));
            } else if (state is RemoveTvShowWatchlistError) {
              hideLoading(context);
              showToast(state.message);
            }
          }),
        ],
        child: BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
          buildWhen: (previousState, state) {
            return state is TvShowDetailLoading ||
                state is TvShowDetailHasData ||
                state is TvShowDetailError;
          },
          builder: (context, state) {
            if (state is TvShowDetailLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvShowDetailHasData) {
              final result = state.result;
              _getTvShowRecommendations();
              _getWatchlistTvShowStatus();
              return DetailContent(result);
            } else if (state is TvShowDetailError) {
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

  void _getWatchlistTvShowStatus() {
    context
        .read<TvShowDetailBloc>()
        .add(FetchedTvShowWatchListStatus(widget.id));
  }

  void _getTvShowRecommendations() {
    context
        .read<TvShowDetailBloc>()
        .add(FetchedTvShowRecommendations(widget.id));
  }
}

class DetailContent extends StatelessWidget {
  final TvShowDetail tvShow;

  DetailContent(this.tvShow);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        context.read<WatchlistTvShowBloc>().add(FetchedWatchlistTvShow());
        return true;
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
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
                                      tvShow.name,
                                      style: kHeading5,
                                    ),
                                  ),
                                  BlocBuilder<TvShowDetailBloc,
                                      TvShowDetailState>(
                                    buildWhen: (previousState, state) {
                                      return state
                                              is TvShowWatchlistStatusLoading ||
                                          state
                                              is TvShowWatchlistStatusHasData ||
                                          state is TvShowWatchlistStatusError;
                                    },
                                    builder: (context, state) {
                                      if (state
                                          is TvShowWatchlistStatusLoading) {
                                        return ElevatedButton(
                                            onPressed: () {},
                                            child: CircularProgressIndicator());
                                      } else if (state
                                          is TvShowWatchlistStatusHasData) {
                                        final isAddedWatchlist = state.result;
                                        return ElevatedButton(
                                          onPressed: () async {
                                            if (!isAddedWatchlist) {
                                              context
                                                  .read<TvShowDetailBloc>()
                                                  .add(AddedWatchlistTvShow(
                                                      tvShow));
                                            } else {
                                              context
                                                  .read<TvShowDetailBloc>()
                                                  .add(RemovedWatchlistTvShow(
                                                      tvShow));
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
                                          is TvShowWatchlistStatusError) {
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
                              SizedBox(height: 8),
                              Text(
                                _showGenres(tvShow.genres),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  RatingBarIndicator(
                                    rating: tvShow.voteAverage / 2,
                                    itemCount: 5,
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: kMikadoYellow,
                                    ),
                                    itemSize: 24,
                                  ),
                                  Text('${tvShow.voteAverage}')
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'Total Episodes',
                                      ),
                                      Text(
                                        tvShow.numberOfEpisodes.toString(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'Total Season',
                                      ),
                                      Text(
                                        tvShow.numberOfSeasons.toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Overview',
                                style: kHeading6,
                              ),
                              Text(
                                tvShow.overview,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Recommendations',
                                style: kHeading6,
                              ),
                              BlocBuilder<TvShowDetailBloc, TvShowDetailState>(
                                buildWhen: (previousState, state) {
                                  return state
                                          is TvShowRecommendationsLoading ||
                                      state is TvShowRecommendationsHasData ||
                                      state is TvShowRecommendationsError;
                                },
                                builder: (context, state) {
                                  if (state is TvShowRecommendationsLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (state
                                      is TvShowRecommendationsHasData) {
                                    final recommendations = state.result;
                                    return Container(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final tvShow = recommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  TvShowDetailPage.ROUTE_NAME,
                                                  arguments: tvShow.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
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
                                      is TvShowRecommendationsError) {
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
}
