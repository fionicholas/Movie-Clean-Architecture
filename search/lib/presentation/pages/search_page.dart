import 'package:core/utils/constants.dart';
import 'search_tv_show_page.dart';
import 'package:flutter/material.dart';

import 'search_movie_page.dart';

class SearchPage extends StatefulWidget {

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
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
    const SearchMoviePage(),
    const SearchTvShowPage(),
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
        title: const Text('Search'),
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
