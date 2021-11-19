import 'package:core/domain/entities/tv_show.dart';
import 'package:core/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class WatchListTvShowTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  WatchListTvShowTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory WatchListTvShowTable.fromTvShowEntity(TvShowDetail tvShowDetail) =>
      WatchListTvShowTable(
        id: tvShowDetail.id,
        name: tvShowDetail.name,
        posterPath: tvShowDetail.posterPath,
        overview: tvShowDetail.overview,
      );

  factory WatchListTvShowTable.fromMap(Map<String, dynamic> map) =>
      WatchListTvShowTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  TvShow toTvShowEntity() => TvShow.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
