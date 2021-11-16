import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchListTvShowPage extends StatelessWidget {
  const WatchListTvShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.microtask(() =>
        Provider.of<WatchlistTvShowNotifier>(context, listen: false)
            .fetchWatchlistTvShows());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<WatchlistTvShowNotifier>(
        builder: (context, data, child) {
          if (data.watchlistState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (data.watchlistState == RequestState.Loaded) {
            return (data.watchlistTvShows.isNotEmpty)
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final tvShow = data.watchlistTvShows[index];
                      return TvShowCard(tvShow);
                    },
                    itemCount: data.watchlistTvShows.length,
                  )
                : Center(
                    child: Text('Tv Show Watch List is Empty'),
                  );
          } else if (data.watchlistState == RequestState.Empty) {
            return Center(
              child: Text('Watch list empty'),
            );
          } else {
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        },
      ),
    );
  }
}
