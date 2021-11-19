import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tv_show/watch_list_tv_show_page.dart';
import 'package:flutter/material.dart';

import 'movie/watch_list_movie_page.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage>
    with TickerProviderStateMixin {
  late TabController _controller;

  List<Widget> _tapList = [
    Tab(
      text: 'Movie',
    ),
    Tab(
      text: 'Tv Show',
    ),
  ];
  final List<Widget> _children = [
    WatchListMoviePage(),
    WatchListTvShowPage(),
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
        title: Text('Watchlist'),
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
