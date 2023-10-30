import 'dart:convert';

import 'package:dicoding_ditonton/data/models/genre_model.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/domain/entities/genre.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTVSeriesDetailModel = TVSeriesDetailResponse(
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    name: "Tagesschau",
    originalName: "Tagesschau",
    genres: List<GenreModel>.from(
      [
        {"id": 10763, "name": "News"},
      ].map(
        (e) => GenreModel.fromJson(e),
      ),
    ),
    overview:
        "German daily news program, the oldest still existing program on German television.",
    voteAverage: 7.386,
    voteCount: 153,
    id: 94722,
  );
  final tTVSeriesDetail = TVSeriesDetail(
    posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
    name: "Tagesschau",
    originalName: "Tagesschau",
    genres: List<Genre>.from(
      [
        {"id": 10763, "name": "News"},
      ].map(
        (e) => Genre.fromJson(e),
      ),
    ),
    overview:
        "German daily news program, the oldest still existing program on German television.",
    voteAverage: 7.386,
    voteCount: 153,
    id: 94722,
  );

  group('toEntity', () {
    test('should return TVSeriesDetail entity correctly', () {
      expect(tTVSeriesDetailModel.toEntity(), tTVSeriesDetail);
    });
  });

  group('toJson', () {
    test(
      'should return JSON Map properly',
      () {
        final expectedJSONMap = {
          "poster_path": "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg",
          "name": "Tagesschau",
          "original_name": "Tagesschau",
          "genres": [
            {"id": 10763, "name": "News"},
          ],
          "overview":
              "German daily news program, the oldest still existing program on German television.",
          "vote_average": 7.386,
          "vote_count": 153,
          "id": 94722,
        };

        expect(tTVSeriesDetailModel.toJson(), expectedJSONMap);
      },
    );
  });

  group('fromJson', () {
    test('should return TVSeriesDetailModel correctly', () {
      final result = TVSeriesDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_series_detail.json')),
      );

      expect(result, tTVSeriesDetailModel);
    });
  });
}
