import 'package:core/presentation/bloc/tv_show/watchlist/watchlist_tv_show_bloc.dart';
import 'package:core/presentation/bloc/tv_show/watchlist/watchlist_tv_show_event.dart';
import 'package:core/presentation/bloc/tv_show/watchlist/watchlist_tv_show_state.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchListTvShowPage extends StatelessWidget {
  const WatchListTvShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<WatchlistTvShowBloc>().add(FetchedWatchlistTvShow());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvShowBloc, WatchlistTvShowState>(
        buildWhen: (previousState, state) {
          return state is WatchlistTvShowLoading ||
              state is WatchlistTvShowHasData ||
              state is WatchlistTvShowError;
        },
        builder: (context, state) {
          if (state is WatchlistTvShowLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistTvShowHasData) {
            final result = state.result;
            if (result.isEmpty) {
              return const Center(
                child: Text('Data tidak ditemukan'),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvShow = result[index];
                        return TvShowCard(tvShow);
                      },
                      itemCount: result.length,
                    ),
                  ),
                ],
              );
            }
          } else if (state is WatchlistTvShowError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
