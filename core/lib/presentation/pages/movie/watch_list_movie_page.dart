import 'package:core/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist/watchlist_movie_event.dart';
import 'package:core/presentation/bloc/movie/watchlist/watchlist_movie_state.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchListMoviePage extends StatelessWidget {
  const WatchListMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WatchlistMovieBloc>().add(FetchedWatchlistMovie());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        buildWhen: (previousState, state) {
          return state is WatchlistMovieLoading ||
              state is WatchlistMovieHasData ||
              state is WatchlistMovieError;
        },
        builder: (context, state) {
          if (state is WatchlistMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistMovieHasData) {
            final result = state.result;
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final movie = result[index];
                  return MovieCard(movie);
                },
                itemCount: result.length,
              ),
            );
          } else if (state is WatchlistMovieError) {
            return Expanded(
              child: Center(
                child: Text(state.message),
              ),
            );
          } else {
            return Expanded(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
