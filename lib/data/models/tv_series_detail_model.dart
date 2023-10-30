import 'package:dicoding_ditonton/data/models/genre_model.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetailResponse extends Equatable {
  final String posterPath;
  final String name;
  final String originalName;
  final List<GenreModel> genres;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final int id;

  TVSeriesDetailResponse({
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

  factory TVSeriesDetailResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesDetailResponse(
          posterPath: json['poster_path'],
          name: json['name'],
          originalName: json['original_name'],
          genres: List<GenreModel>.from(
              json["genres"].map((x) => GenreModel.fromJson(x))),
          overview: json['overview'],
          voteAverage: double.parse(json['vote_average'].toString()),
          voteCount: int.parse(json['vote_count'].toString()),
          id: json['id']);

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "name": name,
        "original_name": originalName,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "overview": overview,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "id": id,
      };

  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
      posterPath: posterPath,
      name: name,
      originalName: originalName,
      genres: genres.map((g) => g.toEntity()).toList(),
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      id: id,
    );
  }
}
