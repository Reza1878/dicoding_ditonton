import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_now_playing_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_series_now_playing_notifier_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

@GenerateMocks([GetNowPlayingTVSeries])
void main() {
  late MockGetNowPlayingTVSeries mockGetNowPlayingTVSeries;
  late TVSeriesNowPlayingNotifier nowPlayingNotifier;

  setUp(() {
    mockGetNowPlayingTVSeries = new MockGetNowPlayingTVSeries();
    nowPlayingNotifier = new TVSeriesNowPlayingNotifier(
      mockGetNowPlayingTVSeries,
    );
  });

  group('fetchNowPlayingTVSeries', () {
    test(
      'should change state to loading when usecase is called',
      () async {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Right([testTVSeries]));

        nowPlayingNotifier.fetchNowPlayingTVSeries();

        expect(nowPlayingNotifier.state, RequestState.Loading);
      },
    );

    test(
      'should change list of tv series when data is gotten successfully',
      () async {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Right([testTVSeries]));

        await nowPlayingNotifier.fetchNowPlayingTVSeries();

        expect(nowPlayingNotifier.state, RequestState.Loaded);
        expect(nowPlayingNotifier.tvSeries, [testTVSeries]);
      },
    );

    test(
      'should return error when usecase call is failed',
      () async {
        when(mockGetNowPlayingTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        await nowPlayingNotifier.fetchNowPlayingTVSeries();

        expect(nowPlayingNotifier.state, RequestState.Error);
        expect(nowPlayingNotifier.message, 'Server Failure');
      },
    );
  });
}
