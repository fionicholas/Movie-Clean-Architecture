import 'package:ditonton/presentation/bloc/tv_show/popular/popular_tv_show_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_show/popular/popular_tv_show_event.dart';
import 'package:ditonton/presentation/bloc/tv_show/popular/popular_tv_show_state.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PopularTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-show';

  @override
  _PopularTvShowsPageState createState() => _PopularTvShowsPageState();
}

class _PopularTvShowsPageState extends State<PopularTvShowsPage> {
  @override
  void initState() {
    super.initState();
    context.read<PopularTvShowBloc>().add(FetchedPopularTvShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvShowBloc, PopularTvShowState>(
          builder: (context, state) {
            if (state is PopularTvShowLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvShowHasData) {
              final result = state.result;
              return Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    final TvShow = result[index];
                    return TvShowCard(TvShow);
                  },
                  itemCount: result.length,
                ),
              );
            } else if (state is PopularTvShowError) {
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
      ),
    );
  }
}
