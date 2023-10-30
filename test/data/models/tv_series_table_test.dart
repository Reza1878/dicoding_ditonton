import 'package:dicoding_ditonton/data/models/tv_series_table.dart';
import 'package:dicoding_ditonton/domain/entities/genre.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesDetail = TVSeriesDetail(
    posterPath: 'poster_path',
    name: 'name',
    originalName: 'originalName',
    genres: List<Genre>.from([
      {'id': 1, 'name': 'name'}
    ].map((e) => Genre.fromJson(e))),
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1,
    id: 1,
  );
  group('fromEntity', () {
    test('should return TVSeriesTable when given TVSeriesDetail object', () {
      final result = TVSeriesTable.fromEntity(tTVSeriesDetail);

      expect(result.id, tTVSeriesDetail.id);
      expect(result.overview, tTVSeriesDetail.overview);
      expect(result.title, tTVSeriesDetail.name);
      expect(result.posterPath, tTVSeriesDetail.posterPath);
    });
  });

  group('fromMap', () {
    test(
      'should return TVSeriesTable when given JSON',
      () {
        final result = TVSeriesTable.fromMap(
          {
            "id": 1,
            "title": 'name',
            "posterPath": "poster_path",
            "overview": "overview"
          },
        );

        expect(result.id, tTVSeriesDetail.id);
        expect(result.overview, tTVSeriesDetail.overview);
        expect(result.title, tTVSeriesDetail.name);
        expect(result.posterPath, tTVSeriesDetail.posterPath);
      },
    );
  });

  group('toJSON', () {
    test('should return JSON correctly', () {
      final expectedJSON = {
        "id": 1,
        "title": "name",
        "posterPath": "poster_path",
        "overview": "overview"
      };
      final tTVSeriesTable = TVSeriesTable.fromEntity(tTVSeriesDetail);

      expect(tTVSeriesTable.toJson(), expectedJSON);
    });
  });

  group('toEntity', () {
    test('should return TVSeriesWatchlist entity correctly', () {
      final tTVSeriesWatchlist = TVSeries.watchlist(
        id: 1,
        overview: 'overview',
        posterPath: 'poster_path',
        name: 'name',
      );
      final tTVSeriesTable = TVSeriesTable.fromEntity(tTVSeriesDetail);

      expect(tTVSeriesTable.toEntity(), tTVSeriesWatchlist);
    });
  });
}
