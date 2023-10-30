import 'dart:convert';

import 'package:dicoding_ditonton/data/models/tv_series_model.dart';
import 'package:dicoding_ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVSeriesModel = TVSeriesModel(
    firstAirDate: '2021-06-09',
    genreIds: [18, 10765],
    id: 84958,
    name: 'Loki',
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: 'Loki',
    overview:
        "After stealing the Tesseract during the events of 'Avengers: Endgame,' an alternate version of Loki is brought to the mysterious Time Variance Authority, a bureaucratic organization that exists outside of time and space and monitors the timeline. They give Loki a choice: face being erased from existence due to being a 'time variant' or help fix the timeline and stop a greater threat.",
    popularity: 2782.511,
    voteAverage: 8.2,
    voteCount: 10333,
    backdropPath: "/q3jHCb4dMfYF6ojikKuHd6LscxC.jpg",
    posterPath: "/voHUmluYmKyleFkTu3lOXQG702u.jpg",
  );
  final tTVSeriesResponseModel =
      TVSeriesResponse(seriesList: <TVSeriesModel>[tTVSeriesModel]);

  group('fromJson', () {
    test(
      'should return a valid model from JSON',
      () async {
        final Map<String, dynamic> jsonMap = json.decode(
          readJson('dummy_data/tv_series_now_playing.json'),
        );

        final result = TVSeriesResponse.fromJson(jsonMap);

        expect(result, tTVSeriesResponseModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a Json map containing proper data',
      () async {
        final result = tTVSeriesResponseModel.toJson();
        final expectedJsonMap = {
          "results": [
            {
              "backdrop_path": "/q3jHCb4dMfYF6ojikKuHd6LscxC.jpg",
              "first_air_date": "2021-06-09",
              "genre_ids": [18, 10765],
              "id": 84958,
              "name": "Loki",
              "origin_country": ["US"],
              "original_language": "en",
              "original_name": "Loki",
              "overview":
                  "After stealing the Tesseract during the events of 'Avengers: Endgame,' an alternate version of Loki is brought to the mysterious Time Variance Authority, a bureaucratic organization that exists outside of time and space and monitors the timeline. They give Loki a choice: face being erased from existence due to being a 'time variant' or help fix the timeline and stop a greater threat.",
              "popularity": 2782.511,
              "poster_path": "/voHUmluYmKyleFkTu3lOXQG702u.jpg",
              "vote_average": 8.2,
              "vote_count": 10333
            }
          ],
        };
        expect(result, expectedJsonMap);
      },
    );
  });
}
