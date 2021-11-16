import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tv_show/watch_list_tv_show_page.dart';
import 'package:flutter/material.dart';

import 'movie/watch_list_movie_page.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  int _currentIndex = 0;
  final List _children = [
    WatchListMoviePage(),
    WatchListTvShowPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kOxfordBlue,
        appBar: AppBar(
          title: Text('Watchlist'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: kRichBlack,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.movie),
              label: 'Movie',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.tv_rounded),
              icon: new Icon(Icons.tv_rounded),
              label: 'Tv Show',
            ),
          ],
        ),
        body: _children[_currentIndex]);
  }
}
