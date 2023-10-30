import 'package:dicoding_ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  final String posterPath;
  final String name;
  final String originalName;
  final List<Genre> genres;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final int id;

  TVSeriesDetail({
    required this.posterPath,
    required this.name,
    required this.originalName,
    required this.genres,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.id,
  });

  @override
  List<Object> get props => [
        posterPath,
        name,
        originalName,
        genres,
        overview,
        voteAverage,
        voteCount,
        id
      ];
}
