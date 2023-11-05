import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/tv_series_now_playing_notifier_test.mocks.dart';

void main() {
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;
  late NowPlayingTvSeriesBloc nowPlayingTvSeriesBloc;

  setUp(() {
    mockGetNowPlayingTVSeries = new MockGetNowPlayingTVSeries();
    nowPlayingTvSeriesBloc =
        new NowPlayingTvSeriesBloc(mockGetNowPlayingTVSeries);
  });

  group(
    'NowPlayingTVSeriesBloc',
    () {
      test('initial state should be NowPlayingTVSeriesInitial', () {
        expect(nowPlayingTvSeriesBloc.state, NowPlayingTvSeriesInitial());
      });

      blocTest(
        'should emit [Loading, Loaded] when get data is success',
        build: () {
          when(mockGetNowPlayingTVSeries.execute()).thenAnswer(
              (realInvocation) => Future.value(Right([testTVSeries])));
          return nowPlayingTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
        expect: () => [
          NowPlayingTVSeriesLoading(),
          NowPlayingTVSeriesLoaded([testTVSeries]),
        ],
        verify: (bloc) {
          mockGetNowPlayingTVSeries.execute();
        },
      );

      blocTest(
        'should emit [Loading, Error] when get data is failed',
        build: () {
          when(mockGetNowPlayingTVSeries.execute()).thenAnswer(
              (realInvocation) =>
                  Future.value(Left(ServerFailure('Server Failure'))));
          return nowPlayingTvSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchNowPlayingTvSeries()),
        expect: () => [
          NowPlayingTVSeriesLoading(),
          NowPlayingTVSeriesError('Server Failure'),
        ],
        verify: (bloc) {
          mockGetNowPlayingTVSeries.execute();
        },
      );
    },
  );
}
