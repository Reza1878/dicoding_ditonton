import 'dart:convert';

import 'package:dicoding_ditonton/common/exception.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/data/models/tv_series_model.dart';
import 'package:dicoding_ditonton/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getNowPlayingTVSeries();
  Future<List<TVSeriesModel>> getTopRatedTVSeries();
  Future<List<TVSeriesModel>> getPopularTVSeries();
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id);
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id);
  Future<List<TVSeriesModel>> searchTVSeries(String query);
}

class TVSeriesRemoteDataSourceImpl extends TVSeriesRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVSeriesModel>> getNowPlayingTVSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/discover/tv?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    }
    throw ServerException();
  }

  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/discover/tv?$API_KEY&sort_by=popularity.desc'),
    );

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    }
    throw ServerException();
  }

  @override
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    }
    throw ServerException();
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTVSeries() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/discover/tv?$API_KEY&sort_by=vote_average.desc'),
    );
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    }
    throw ServerException();
  }

  @override
  Future<TVSeriesDetailResponse> getTVSeriesDetail(int id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/tv/$id?$API_KEY'),
    );

    if (response.statusCode == 200) {
      return TVSeriesDetailResponse.fromJson(json.decode(response.body));
    }

    throw ServerException();
  }

  @override
  Future<List<TVSeriesModel>> searchTVSeries(String query) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'),
    );
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).seriesList;
    }
    throw ServerException();
  }
}
