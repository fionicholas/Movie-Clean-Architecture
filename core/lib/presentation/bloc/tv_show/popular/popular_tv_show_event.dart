import 'package:equatable/equatable.dart';

abstract class PopularTvShowEvent extends Equatable {
  const PopularTvShowEvent();

  @override
  List<Object> get props => [];
}

class FetchedPopularTvShow extends PopularTvShowEvent {
  FetchedPopularTvShow();

  @override
  List<Object> get props => [];
}
