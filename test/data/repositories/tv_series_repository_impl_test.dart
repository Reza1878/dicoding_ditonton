import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/exception.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/data/models/tv_series_model.dart';
import 'package:dicoding_ditonton/data/repositories/tv_series_repository_impl.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;
  late MockTVSeriesLocalDataSource mockLocalDataSource;
  late TVSeriesRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = new MockTVSeriesRemoteDataSource();
    mockLocalDataSource = new MockTVSeriesLocalDataSource();
    repository = new TVSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTVSeriesModel = TVSeriesModel(
    firstAirDate: '2023-10-10',
    genreIds: [1],
    id: 1,
    name: 'name',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: '',
    overview: 'overview',
    popularity: 1,
    voteAverage: 1,
    voteCount: 1,
    posterPath: 'poster_path',
  );

  group('getNowPlayingTVSeries', () {
    test(
      'should return List of TV Series when success',
      () async {
        when(mockRemoteDataSource.getNowPlayingTVSeries()).thenAnswer(
          (_) async => [tTVSeriesModel],
        );

        final result = await repository.getNowPlayingTVSeries();
        verify(mockRemoteDataSource.getNowPlayingTVSeries());

        final resultList = result.getOrElse(() => []);

        expect(resultList, [tTVSeriesModel.toEntity()]);
      },
    );

    test(
      'should return ServerFailure when failed to get data',
      () async {
        when(mockRemoteDataSource.getNowPlayingTVSeries())
            .thenThrow(ServerException());

        final result = await repository.getNowPlayingTVSeries();

        verify(mockRemoteDataSource.getNowPlayingTVSeries());

        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return ConnectionFailure when the device is not connected to internet',
      () async {
        when(mockRemoteDataSource.getNowPlayingTVSeries()).thenThrow(
          SocketException('No internet'),
        );

        final result = await repository.getNowPlayingTVSeries();

        verify(mockRemoteDataSource.getNowPlayingTVSeries());
        expect(
          result,
          equals(
            Left(
              ConnectionFailure('Failed to connect to the network'),
            ),
          ),
        );
      },
    );
  });

  group('getPopularTVSeries', () {
    test(
      'should return List of TV Series when api call is success',
      () async {
        when(mockRemoteDataSource.getPopularTVSeries())
            .thenAnswer((_) async => [tTVSeriesModel]);

        final result = await repository.getPopularTVSeries();

        verify(mockRemoteDataSource.getPopularTVSeries());

        final resultList = result.getOrElse(() => []);

        expect(resultList, [tTVSeriesModel.toEntity()]);
      },
    );

    test(
      'should return ServerFailure when API call is failed',
      () async {
        when(mockRemoteDataSource.getPopularTVSeries())
            .thenThrow(ServerException());

        final result = await repository.getPopularTVSeries();
        verify(mockRemoteDataSource.getPopularTVSeries());
        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to internet',
      () async {
        when(mockRemoteDataSource.getPopularTVSeries())
            .thenThrow(SocketException('No internet'));

        final result = await repository.getPopularTVSeries();
        verify(mockRemoteDataSource.getPopularTVSeries());
        expect(
          result,
          equals(
            Left(ConnectionFailure('Failed to connect to the network')),
          ),
        );
      },
    );
  });

  group('getTVSeriesRecommendations', () {
    final tId = 1;

    test(
      'should return List of TV Series when API call is success',
      () async {
        when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
            .thenAnswer((_) async => [tTVSeriesModel]);

        final result = await repository.getTVSeriesRecommendations(tId);
        verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));

        final resultList = result.getOrElse(() => []);

        expect(resultList, [tTVSeriesModel.toEntity()]);
      },
    );

    test(
      'should return ServerFailure when API call is failed',
      () async {
        when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
            .thenThrow(ServerException());

        final result = await repository.getTVSeriesRecommendations(tId);
        verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));

        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to internet',
      () async {
        when(mockRemoteDataSource.getTVSeriesRecommendations(tId))
            .thenThrow(SocketException('No internet'));

        final result = await repository.getTVSeriesRecommendations(tId);
        verify(mockRemoteDataSource.getTVSeriesRecommendations(tId));

        expect(
          result,
          equals(
            Left(
              ConnectionFailure('Failed to connect to the network'),
            ),
          ),
        );
      },
    );
  });

  group('getTopRatedTVSeries', () {
    test(
      'should return List of TV Series when call to remote data source is success',
      () async {
        when(mockRemoteDataSource.getTopRatedTVSeries())
            .thenAnswer((_) async => [tTVSeriesModel]);

        final result = await repository.getTopRatedTVSeries();
        verify(mockRemoteDataSource.getTopRatedTVSeries());

        final resultList = result.getOrElse(() => []);

        expect(resultList, [tTVSeriesModel.toEntity()]);
      },
    );

    test(
      'should return ServerFailure when call to remote data source is failed',
      () async {
        when(mockRemoteDataSource.getTopRatedTVSeries())
            .thenThrow(ServerException());

        final result = await repository.getTopRatedTVSeries();
        verify(mockRemoteDataSource.getTopRatedTVSeries());

        expect(result, equals(Left(ServerFailure(''))));
      },
    );

    test(
      'should return ConnectionFailuer when device is not connected to interner',
      () async {
        when(mockRemoteDataSource.getTopRatedTVSeries())
            .thenThrow(SocketException('No internet'));

        final result = await repository.getTopRatedTVSeries();
        verify(mockRemoteDataSource.getTopRatedTVSeries());

        expect(
          result,
          equals(
            Left(
              ConnectionFailure('Failed to connect to the network'),
            ),
          ),
        );
      },
    );
  });

  group('getTVSeriesDetail', () {
    final tTVSeriesDetail = TVSeriesDetailResponse.fromJson(
      json.decode(
        readJson('dummy_data/tv_series_detail.json'),
      ),
    );
    final tId = 1;

    test(
      'should return TV Series Detail when call to remote data source is success',
      () async {
        when(mockRemoteDataSource.getTVSeriesDetail(tId))
            .thenAnswer((_) async => tTVSeriesDetail);

        final result = await repository.getTVSeriesDetail(tId);
        verify(mockRemoteDataSource.getTVSeriesDetail(tId));

        expect(result, Right(tTVSeriesDetail.toEntity()));
      },
    );

    test(
      'should return ServerFailure when call to remote data source is failed',
      () async {
        when(mockRemoteDataSource.getTVSeriesDetail(tId))
            .thenThrow(ServerException());

        final result = await repository.getTVSeriesDetail(tId);
        verify(mockRemoteDataSource.getTVSeriesDetail(tId));

        expect(result, Left(ServerFailure('')));
      },
    );

    test(
      'should return ConnectionFailure when device is not connected to internet',
      () async {
        when(mockRemoteDataSource.getTVSeriesDetail(tId))
            .thenThrow(SocketException('No internet'));

        final result = await repository.getTVSeriesDetail(tId);
        verify(mockRemoteDataSource.getTVSeriesDetail(tId));

        expect(
          result,
          Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        );
      },
    );
  });

  group('searchTVSeries', () {
    final tQuery = 'test';
    test(
      'should return List of TV Series when call to remote data source is success',
      () async {
        when(mockRemoteDataSource.searchTVSeries(tQuery))
            .thenAnswer((_) async => [tTVSeriesModel]);

        final result = await repository.searchTVSeries(tQuery);
        verify(mockRemoteDataSource.searchTVSeries(tQuery));

        final resultList = result.getOrElse(() => []);
        expect(resultList, [tTVSeriesModel.toEntity()]);
      },
    );
    test(
      'should return ServerFailure when call to remote data source is failed',
      () async {
        when(mockRemoteDataSource.searchTVSeries(tQuery))
            .thenThrow(ServerException());

        final result = await repository.searchTVSeries(tQuery);
        verify(mockRemoteDataSource.searchTVSeries(tQuery));

        expect(result, Left(ServerFailure('')));
      },
    );
    test(
      'should return ConnectionFailure when device is not connected to internet',
      () async {
        when(mockRemoteDataSource.searchTVSeries(tQuery))
            .thenThrow(SocketException('No internet'));

        final result = await repository.searchTVSeries(tQuery);
        verify(mockRemoteDataSource.searchTVSeries(tQuery));

        expect(
          result,
          Left(
            ConnectionFailure('Failed to connect to the network'),
          ),
        );
      },
    );
  });

  group('getWatchlistTVSeries', () {
    test(
      'should return List of TV Series when call to local data source is success',
      () async {
        when(mockLocalDataSource.getWatchlistTVSeries())
            .thenAnswer((_) async => [testTVSeriesTable]);

        final result = await repository.getWatchlistTVSeries();
        verify(mockLocalDataSource.getWatchlistTVSeries());

        final resultList = result.getOrElse(() => []);

        expect(resultList, [testTVSeriesTable.toEntity()]);
      },
    );
  });

  group('isAddedToWatchlist', () {
    final tId = 1;
    test(
      'should return true if TV Series is in watchlist',
      () async {
        when(mockLocalDataSource.getTVSeriesById(tId))
            .thenAnswer((_) async => testTVSeriesTable);

        final result = await repository.isAddedToWatchlist(tId);
        verify(mockLocalDataSource.getTVSeriesById(tId));

        expect(result, true);
      },
    );
    test(
      'should return false if TV Series is not in watchlist',
      () async {
        when(mockLocalDataSource.getTVSeriesById(tId))
            .thenAnswer((_) async => null);

        final result = await repository.isAddedToWatchlist(tId);
        verify(mockLocalDataSource.getTVSeriesById(tId));

        expect(result, false);
      },
    );
  });

  group('removeWatchlist', () {
    final tTVSeriesDetail = TVSeriesDetailResponse.fromJson(
      testTVSeriesDetailMap,
    );
    test(
      'should return success message when remove watchlist is success',
      () async {
        when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
            .thenAnswer((_) async => 'Removed from Watchlist');

        final result = await repository.removeWatchlist(
          tTVSeriesDetail.toEntity(),
        );
        verify(mockLocalDataSource.removeWatchlist(testTVSeriesTable));

        expect(result, equals(Right('Removed from Watchlist')));
      },
    );

    test(
      'should return DatabaseFailure when remove watchlist is failed',
      () async {
        when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
            .thenThrow(DatabaseException('Error'));

        final result = await repository.removeWatchlist(
          tTVSeriesDetail.toEntity(),
        );
        verify(mockLocalDataSource.removeWatchlist(testTVSeriesTable));

        expect(result, equals(Left(DatabaseFailure('Error'))));
      },
    );
  });

  group('saveWatchlist', () {
    final tTVSeriesDetail = TVSeriesDetailResponse.fromJson(
      testTVSeriesDetailMap,
    );
    test(
      'should return Success Message when save watchlist is success',
      () async {
        when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
            .thenAnswer((_) async => 'Saved to Watchlist');

        final result = await repository.saveWatchlist(
          tTVSeriesDetail.toEntity(),
        );
        verify(mockLocalDataSource.insertWatchlist(testTVSeriesTable));

        expect(
          result,
          equals(
            Right('Saved to Watchlist'),
          ),
        );
      },
    );
    test(
      'should return DatabaseFailure when save watchlist is failed',
      () async {
        when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
            .thenThrow(DatabaseException('Error'));

        final result = await repository.saveWatchlist(
          tTVSeriesDetail.toEntity(),
        );
        verify(mockLocalDataSource.insertWatchlist(testTVSeriesTable));

        expect(
          result,
          equals(
            Left(DatabaseFailure('Error')),
          ),
        );
      },
    );
  });
}
