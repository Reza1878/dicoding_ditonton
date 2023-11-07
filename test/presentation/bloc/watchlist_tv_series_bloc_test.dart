import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/data/models/tv_series_detail_model.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_series_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTVSeries,
  GetTVSeriesWatchlistStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist
])
void main() {
  late MockGetWatchlistTVSeries getWatchlistTVSeries;
  late MockGetTVSeriesWatchlistStatus getTVSeriesWatchlistStatus;
  late MockSaveTVSeriesWatchlist saveTVSeriesWatchlist;
  late MockRemoveTVSeriesWatchlist removeTVSeriesWatchlist;
  late WatchlistTvSeriesBloc watchlistTvSeriesBloc;

  setUp(() {
    getWatchlistTVSeries = new MockGetWatchlistTVSeries();
    getTVSeriesWatchlistStatus = new MockGetTVSeriesWatchlistStatus();
    saveTVSeriesWatchlist = new MockSaveTVSeriesWatchlist();
    removeTVSeriesWatchlist = new MockRemoveTVSeriesWatchlist();
    watchlistTvSeriesBloc = new WatchlistTvSeriesBloc(
      getWatchlistTVSeries: getWatchlistTVSeries,
      getTVSeriesWatchlistStatus: getTVSeriesWatchlistStatus,
      saveTVSeriesWatchlist: saveTVSeriesWatchlist,
      removeWatchlistTVSeries: removeTVSeriesWatchlist,
    );
  });

  group('TVSeriesWatchlistBloc', () {
    final tId = 1;
    final testTVSeriesDetail = TVSeriesDetailResponse.fromJson(
      testTVSeriesDetailMap,
    ).toEntity();
    test('initial state should be TVSeriesWatchlistInitial', () {
      expect(watchlistTvSeriesBloc.state, WatchlistTvSeriesInitial());
    });

    group('LoadWatchlistTVSeriesStatus', () {
      blocTest(
        'should emit [StatusLoaded] with status false if tv series is not in watchlist',
        build: () {
          when(getTVSeriesWatchlistStatus.execute(tId))
              .thenAnswer((realInvocation) => Future.value(false));
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistTVSeriesStatus(tId)),
        expect: () => [
          WatchlistTVSeriesStatusLoaded(status: false),
        ],
        verify: (bloc) {
          verify(getTVSeriesWatchlistStatus.execute(tId));
        },
      );
      blocTest(
        'should emit [StatusLoaded] with status true if tv series is in watchlist',
        build: () {
          when(getTVSeriesWatchlistStatus.execute(tId))
              .thenAnswer((realInvocation) => Future.value(true));
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistTVSeriesStatus(tId)),
        expect: () => [
          WatchlistTVSeriesStatusLoaded(status: true),
        ],
        verify: (bloc) {
          verify(getTVSeriesWatchlistStatus.execute(tId));
        },
      );
    });

    group('SaveWatchlistTVSeries', () {
      blocTest(
        'should emit [StatusLoaded] with status true and success message when save watchlist is success',
        build: () {
          when(saveTVSeriesWatchlist.execute(testTVSeriesDetail)).thenAnswer(
              (realInvocation) => Future.value(Right('Added to Watchlist')));
          when(getTVSeriesWatchlistStatus.execute(tId))
              .thenAnswer((realInvocation) => Future.value(true));
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistTVSeries(testTVSeriesDetail)),
        expect: () => [
          WatchlistTVSeriesStatusLoaded(
              status: true, message: 'Added to Watchlist'),
        ],
        verify: (bloc) {
          saveTVSeriesWatchlist.execute(testTVSeriesDetail);
          getTVSeriesWatchlistStatus.execute(tId);
        },
      );
      blocTest(
        'should emit [StatusLoaded] with status false and error message when save watchlist is failed',
        build: () {
          when(saveTVSeriesWatchlist.execute(testTVSeriesDetail)).thenAnswer(
            (realInvocation) => Future.value(Left(DatabaseFailure('Failed'))),
          );
          when(getTVSeriesWatchlistStatus.execute(tId)).thenAnswer(
            (realInvocation) => Future.value(false),
          );
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistTVSeries(testTVSeriesDetail)),
        expect: () => [
          WatchlistTVSeriesStatusLoaded(
            status: false,
            message: 'Failed',
          ),
        ],
        verify: (bloc) {
          saveTVSeriesWatchlist.execute(testTVSeriesDetail);
          getTVSeriesWatchlistStatus.execute(tId);
        },
      );
    });

    group('RemoveWatchlistTVSeries', () {
      blocTest(
        'should emit [StatusLoaded] with status false and success message when remove watchlist is success',
        build: () {
          when(removeTVSeriesWatchlist.execute(testTVSeriesDetail)).thenAnswer(
              (realInvocation) =>
                  Future.value(Right('Removed from Watchlist')));
          when(getTVSeriesWatchlistStatus.execute(tId))
              .thenAnswer((realInvocation) => Future.value(false));
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistTVSeries(testTVSeriesDetail)),
        expect: () => [
          WatchlistTVSeriesStatusLoaded(
            status: false,
            message: 'Removed from Watchlist',
          ),
        ],
        verify: (bloc) {
          removeTVSeriesWatchlist.execute(testTVSeriesDetail);
          getTVSeriesWatchlistStatus.execute(tId);
        },
      );
      blocTest(
        'should emit [StatusLoaded] with status true and error message when save watchlist is failed',
        build: () {
          when(removeTVSeriesWatchlist.execute(testTVSeriesDetail)).thenAnswer(
            (realInvocation) => Future.value(Left(DatabaseFailure('Failed'))),
          );
          when(getTVSeriesWatchlistStatus.execute(tId)).thenAnswer(
            (realInvocation) => Future.value(false),
          );
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnRemoveWatchlistTVSeries(testTVSeriesDetail)),
        expect: () => [
          WatchlistTVSeriesStatusLoaded(
            status: false,
            message: 'Failed',
          ),
        ],
        verify: (bloc) {
          removeTVSeriesWatchlist.execute(testTVSeriesDetail);
          getTVSeriesWatchlistStatus.execute(tId);
        },
      );
    });

    group('OnFetchWatchlistTVSeries', () {
      blocTest(
        'should emit [Loading, Error] when get data is failed',
        build: () {
          when(getWatchlistTVSeries.execute()).thenAnswer((realInvocation) =>
              Future.value(Left(ServerFailure('Server Failure'))));
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchlistTVSeries()),
        expect: () => [
          WatchlistTVSeriesLoading(),
          WatchlistTVSeriesError('Server Failure')
        ],
        verify: (bloc) {
          verify(getWatchlistTVSeries.execute());
        },
      );

      blocTest(
        'should emit [Loading, Loaded] when get data is success',
        build: () {
          when(getWatchlistTVSeries.execute()).thenAnswer(
              (realInvocation) => Future.value(Right([testTVSeries])));
          return watchlistTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchlistTVSeries()),
        expect: () => [
          WatchlistTVSeriesLoading(),
          WatchlistTVSeriesLoaded([testTVSeries])
        ],
        verify: (bloc) {
          verify(getWatchlistTVSeries.execute());
        },
      );
    });
  });
}
