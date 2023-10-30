import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendations,
  GetTVSeriesWatchlistStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist
])
void main() {
  final watchlistAddSuccessMessage = 'Added to Watchlist';
  final watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockGetTVSeriesWatchlistStatus mockGetTVSeriesWatchlistStatus;
  late MockSaveTVSeriesWatchlist mockSaveTVSeriesWatchlist;
  late MockRemoveTVSeriesWatchlist mockRemoveTVSeriesWatchlist;
  late TVSeriesDetailNotifier provider;
  final tId = 1;

  setUp(() {
    mockGetTVSeriesDetail = new MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = new MockGetTVSeriesRecommendations();
    mockGetTVSeriesWatchlistStatus = new MockGetTVSeriesWatchlistStatus();
    mockSaveTVSeriesWatchlist = new MockSaveTVSeriesWatchlist();
    mockRemoveTVSeriesWatchlist = new MockRemoveTVSeriesWatchlist();
    provider = new TVSeriesDetailNotifier(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
      getTVSeriesWatchlistStatus: mockGetTVSeriesWatchlistStatus,
      saveTVSeriesWatchlist: mockSaveTVSeriesWatchlist,
      removeTVSeriesWatchlist: mockRemoveTVSeriesWatchlist,
    );
  });

  group('fetchTVSeriesDetail', () {
    final testTVSeriesDetail =
        TVSeriesDetailResponse.fromJson(testTVSeriesDetailMap).toEntity();
    void _arrangeUsecase() {
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      when(mockGetTVSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right([testTVSeries]));
    }

    test(
      'should change request state to loading when method is called',
      () async {
        _arrangeUsecase();
        provider.fetchTVSeriesDetail(tId);

        expect(provider.tvSeriesState, RequestState.Loading);
      },
    );

    test(
      'should change tv series data when usecase is called',
      () async {
        _arrangeUsecase();

        await provider.fetchTVSeriesDetail(tId);

        verify(mockGetTVSeriesDetail.execute(tId));
        expect(provider.tvSeriesState, RequestState.Loaded);
        expect(provider.tvSeries, testTVSeriesDetail);
      },
    );

    test(
      'should change tv series data when usecase is called',
      () async {
        _arrangeUsecase();

        await provider.fetchTVSeriesDetail(tId);

        verify(mockGetTVSeriesRecommendations.execute(tId));
        expect(provider.recommendationState, RequestState.Loaded);
        expect(provider.recommendations, [testTVSeries]);
      },
    );
  });

  group('addWatchlist', () {
    final testTVSeriesDetail =
        TVSeriesDetailResponse.fromJson(testTVSeriesDetailMap).toEntity();
    test(
      'should change watchlist message when usecase call is success',
      () async {
        when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
            .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
        when(mockGetTVSeriesWatchlistStatus.execute(testTVSeriesDetail.id))
            .thenAnswer((_) async => false);

        await provider.addWatchlist(testTVSeriesDetail);

        verify(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail));
        expect(provider.watchlistMessage, watchlistAddSuccessMessage);
      },
    );

    test(
      'should change watchlist message when usecase call is failed',
      () async {
        when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail)).thenAnswer(
            (_) async => Left(DatabaseFailure('Failed to add watchlist')));
        when(mockGetTVSeriesWatchlistStatus.execute(testTVSeriesDetail.id))
            .thenAnswer((_) async => false);

        await provider.addWatchlist(testTVSeriesDetail);

        verify(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail));
        expect(provider.watchlistMessage, 'Failed to add watchlist');
      },
    );
  });

  group('removeWatchlist', () {
    final testTVSeriesDetail =
        TVSeriesDetailResponse.fromJson(testTVSeriesDetailMap).toEntity();
    test(
      'should change watchlist message when usecase call is success',
      () async {
        when(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail))
            .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
        when(mockGetTVSeriesWatchlistStatus.execute(testTVSeriesDetail.id))
            .thenAnswer((_) async => false);

        await provider.removeFromWatchlist(testTVSeriesDetail);

        verify(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail));
        expect(provider.watchlistMessage, watchlistRemoveSuccessMessage);
      },
    );

    test(
      'should change watchlist message when usecase call is failed',
      () async {
        when(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail))
            .thenAnswer((_) async =>
                Left(DatabaseFailure('Failed to remove watchlist')));
        when(mockGetTVSeriesWatchlistStatus.execute(testTVSeriesDetail.id))
            .thenAnswer((_) async => false);

        await provider.removeFromWatchlist(testTVSeriesDetail);

        verify(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail));
        expect(provider.watchlistMessage, 'Failed to remove watchlist');
      },
    );
  });

  group('loadWatchlistStatus', () {
    test(
      'should change isAddedToWatchlist data from usecase',
      () async {
        when(mockGetTVSeriesWatchlistStatus.execute(tId))
            .thenAnswer((_) async => true);

        await provider.loadWatchlistStatus(tId);

        verify(provider.loadWatchlistStatus(tId));
        expect(provider.isAddedToWatchlist, true);
      },
    );
  });
}
