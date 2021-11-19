import 'package:core/presentation/pages/tv_show/watch_list_tv_show_page.dart';
import 'package:core/utils/constants.dart';
import 'package:flutter/material.dart';

import 'movie/watch_list_movie_page.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with TickerProviderStateMixin {
  late TabController _controller;

  final List<Widget> _tapList = [
    const Tab(
      text: 'Movie',
    ),
    const Tab(
      text: 'Tv Show',
    ),
  ];
  final List<Widget> _children = [
    const WatchListMoviePage(),
    const WatchListTvShowPage(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: _tapList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOxfordBlue,
      appBar: AppBar(
        title: const Text('Watchlist'),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: _tapList,
        ),
      ),
      body: TabBarView(controller: _controller, children: _children),
    );
  }
}
