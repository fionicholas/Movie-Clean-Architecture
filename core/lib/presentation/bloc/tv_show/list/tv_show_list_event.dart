import 'package:equatable/equatable.dart';

abstract class TvShowListEvent extends Equatable {
  const TvShowListEvent();

  @override
  List<Object> get props => [];
}

class FetchedNowPlayingTvShowList extends TvShowListEvent {
  FetchedNowPlayingTvShowList();

  @override
  List<Object> get props => [];
}

class FetchedPopularTvShowList extends TvShowListEvent {
  FetchedPopularTvShowList();

  @override
  List<Object> get props => [];
}

class FetchedTopRatedTvShowList extends TvShowListEvent {
  FetchedTopRatedTvShowList();

  @override
  List<Object> get props => [];
}