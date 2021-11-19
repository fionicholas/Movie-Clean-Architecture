import 'package:core/utils/constants.dart';
import 'package:core/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_bloc.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_event.dart';
import 'package:search/presentation/bloc/tv_show/search/search_tv_show_state.dart';

class SearchTvShowPage extends StatelessWidget {
  const SearchTvShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (query) {
              context.read<SearchTvShowBloc>().add(OnQueryTvShowChanged(query));
            },
            decoration: InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          BlocBuilder<SearchTvShowBloc, SearchTvShowState>(
            builder: (context, state) {
              if (state is SearchTvShowLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvShowHasData) {
                final result = state.result;
                return (result.isNotEmpty)
                    ? Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final movie = result[index];
                      return TvShowCard(movie);
                    },
                    itemCount: result.length,
                  ),
                )
                    : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Text('Data not found'),
                  ),
                );
              } else if (state is SearchTvShowError) {
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
    );
  }
}
