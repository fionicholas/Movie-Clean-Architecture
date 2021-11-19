import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tv_show/search_tv_show_page.dart';
import 'package:flutter/material.dart';

import 'movie/search_movie_page.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
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
    SearchMoviePage(),
    SearchTvShowPage(),
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
        title: Text('Search'),
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: _tapList,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: _children
      ),
    );
  }
}
