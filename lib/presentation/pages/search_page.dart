import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tv_show/search_tv_show_page.dart';
import 'package:flutter/material.dart';

import 'movie/search_movie_page.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 0;
  final List _children = [
    SearchMoviePage(),
    SearchTvShowPage(),
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
          title: Text('Search'),
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
