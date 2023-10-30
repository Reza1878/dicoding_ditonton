import 'package:dicoding_ditonton/data/datasources/db/database_helper.dart';
import 'package:dicoding_ditonton/data/datasources/movie_local_data_source.dart';
import 'package:dicoding_ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:dicoding_ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:dicoding_ditonton/data/datasources/tv_series_remote_data_source.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  TVSeriesRepository,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
