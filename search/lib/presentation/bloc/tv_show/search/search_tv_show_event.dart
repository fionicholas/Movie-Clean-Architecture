import 'package:equatable/equatable.dart';

abstract class SearchTvShowEvent extends Equatable {
  const SearchTvShowEvent();

  @override
  List<Object> get props => [];
}

class OnQueryTvShowChanged extends SearchTvShowEvent {
  final String query;

  const OnQueryTvShowChanged(this.query);

  @override
  List<Object> get props => [query];
}