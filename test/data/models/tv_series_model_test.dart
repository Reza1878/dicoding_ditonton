import 'package:dicoding_ditonton/data/models/tv_series_model.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVSeriesModel = TVSeriesModel(
    firstAirDate: '2023-10-10',
    genreIds: [1],
    id: 1,
    name: 'Loki',
    originCountry: ['en'],
    originalLanguage: 'lang',
    originalName: 'Loki',
    overview: 'overview',
    popularity: 10,
    voteAverage: 10,
    voteCount: 10,
  );

  final tTVSeries = TVSeries(
    firstAirDate: '2023-10-10',
    genreIds: [1],
    id: 1,
    name: 'Loki',
    originCountry: ['en'],
    originalLanguage: 'lang',
    originalName: 'Loki',
    overview: 'overview',
    popularity: 10,
    voteAverage: 10,
    voteCount: 10,
  );

  test(
    'should be a subclass of TVSeries entity',
    () {
      final result = tTVSeriesModel.toEntity();

      expect(result, tTVSeries);
    },
  );
}
