import 'dart:convert';

import 'package:dicoding_ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:dicoding_ditonton/common/exception.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVSeriesRemoteDataSource dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    'get Now Playing TV Series',
    () {
      final tTVSeriesList = TVSeriesResponse.fromJson(
        json.decode(
          readJson('dummy_data/tv_series_now_playing.json'),
        ),
      ).seriesList;

      test(
        'should return list of TV Series Model when then response code is 200',
        () async {
          when(
            mockHttpClient.get(
              Uri.parse('$BASE_URL/discover/tv?$API_KEY'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              readJson('dummy_data/tv_series_now_playing.json'),
              200,
            ),
          );

          final result = await dataSource.getNowPlayingTVSeries();

          expect(result, equals(tTVSeriesList));
        },
      );

      test(
        'should throw a ServerException when then response code is 404 or other',
        () async {
          when(
            mockHttpClient.get(
              Uri.parse('$BASE_URL/discover/tv?$API_KEY'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'Not Found',
              404,
            ),
          );

          final call = dataSource.getNowPlayingTVSeries();

          expect(() => call, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group('get Popular TV Series', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_series_now_playing.json'),
      ),
    ).seriesList;

    test(
      'should return list of tv series when status code is 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse(
              '$BASE_URL/discover/tv?$API_KEY&sort_by=popularity.desc',
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_now_playing.json'),
            200,
          ),
        );

        final result = await dataSource.getPopularTVSeries();

        expect(result, tTVSeriesList);
      },
    );

    test(
      'should throw server exception if status code != 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/discover/tv?$API_KEY&sort_by=popularity.desc'),
          ),
        ).thenAnswer((_) async => http.Response('Not authorized', 401));

        final call = dataSource.getPopularTVSeries();

        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get Top Rated TV Series', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_series_now_playing.json'),
      ),
    ).seriesList;

    test(
      'should return tv series list if status code = 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse(
              '$BASE_URL/discover/tv?$API_KEY&sort_by=vote_average.desc',
            ),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_now_playing.json'),
            200,
          ),
        );

        final result = await dataSource.getTopRatedTVSeries();

        expect(result, tTVSeriesList);
      },
    );

    test(
      'should throw server exception if status code != 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse(
              '$BASE_URL/discover/tv?$API_KEY&sort_by=vote_average.desc',
            ),
          ),
        ).thenAnswer((_) async => http.Response('Not Found', 404));

        final call = dataSource.getTopRatedTVSeries();

        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get TV Series Detail', () {
    final tId = 1;
    final tTVSeriesDetail = TVSeriesDetailResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_series_detail.json'),
      ),
    );

    test(
      'should return tv series detail when response code is 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$tId?$API_KEY'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_detail.json'),
            200,
          ),
        );

        final result = await dataSource.getTVSeriesDetail(tId);

        expect(result, tTVSeriesDetail);
      },
    );

    test(
      'should throw ServerException whn response code is not 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$tId?$API_KEY'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Not found', 404),
        );

        final call = dataSource.getTVSeriesDetail(tId);

        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('get TV Series Recommendations', () {
    final tId = 1;
    final tTVSeriesRecommendations = TVSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_series_recommendations.json'),
      ),
    ).seriesList;

    test(
      'should return tv series list when status code is 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_recommendations.json'),
            200,
          ),
        );

        final result = await dataSource.getTVSeriesRecommendations(tId);

        expect(result, tTVSeriesRecommendations);
      },
    );

    test(
      'should throw ServerException when status code is not 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY'),
          ),
        ).thenAnswer(
          (_) async => http.Response('Not Found', 404),
        );

        final call = dataSource.getTVSeriesRecommendations(tId);

        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });

  group('search TV Series', () {
    final tTVSeriesList = TVSeriesResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_series_now_playing.json'),
      ),
    ).seriesList;
    final query = "TEST";

    test(
      'should return TV Series List when status code is 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            readJson('dummy_data/tv_series_now_playing.json'),
            200,
          ),
        );

        final result = await dataSource.searchTVSeries(query);

        expect(result, tTVSeriesList);
      },
    );

    test(
      'should throw ServerError when status code is not 200',
      () async {
        when(
          mockHttpClient.get(
            Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'Not Found',
            404,
          ),
        );

        final call = dataSource.searchTVSeries(query);

        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
