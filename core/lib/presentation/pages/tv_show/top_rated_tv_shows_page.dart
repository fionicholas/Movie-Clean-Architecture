import 'package:core/presentation/bloc/tv_show/top_rated/top_rated_tv_show_bloc.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/top_rated_tv_show_event.dart';
import 'package:core/presentation/bloc/tv_show/top_rated/top_rated_tv_show_state.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TopRatedTvShowsPage extends StatefulWidget {

  @override
  _TopRatedTvShowsPageState createState() => _TopRatedTvShowsPageState();
}

class _TopRatedTvShowsPageState extends State<TopRatedTvShowsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TopRatedTvShowBloc>().add(FetchedTopRatedTvShow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvShowBloc, TopRatedTvShowState>(
          builder: (context, state) {
            if (state is TopRatedTvShowLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedTvShowHasData) {
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
            } else if (state is TopRatedTvShowError) {
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
