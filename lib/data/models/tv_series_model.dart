import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TVSeriesModel extends Equatable {
  TVSeriesModel({
    this.backdropPath,
    required this.firstAirDate,
    required this.genreIds,
    required this.id,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  final String firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  String? posterPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount
      ];

  factory TVSeriesModel.fromJson(Map<String, dynamic> json) => TVSeriesModel(
        backdropPath: json['backdrop_path'],
        firstAirDate: json['first_air_date'] ?? "",
        genreIds: List<int>.from(
          json['genre_ids'].map((x) => x),
        ),
        id: json['id'],
        name: json['name'],
        originCountry: List<String>.from(
          json['origin_country'].map((x) => x),
        ),
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: double.parse(json['popularity'].toString()),
        posterPath: json['poster_path'],
        voteAverage: double.parse(json['vote_average'].toString()),
        voteCount: json['vote_count'],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genre_ids": genreIds,
        "id": id,
        "name": name,
        "origin_country": originCountry,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  TVSeries toEntity() => TVSeries(
        backdropPath: backdropPath,
        firstAirDate: firstAirDate,
        genreIds: genreIds,
        id: id,
        name: name,
        originCountry: originCountry,
        originalLanguage: originalLanguage,
        originalName: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
