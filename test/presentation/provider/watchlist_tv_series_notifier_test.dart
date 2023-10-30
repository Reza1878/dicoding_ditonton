import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:dicoding_ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_series_notifier_test.mocks.dart';
import '../../dummy_data/dummy_objects.dart';

@GenerateMocks([GetWatchlistTVSeries])
void main() {
  late MockGetWatchlistTVSeries usecase;
  late WatchlistTVSeriesNotifier provider;

  setUp(() {
    usecase = new MockGetWatchlistTVSeries();
    provider = new WatchlistTVSeriesNotifier(getWatchlistTVSeries: usecase);
  });

  group('fetchWatchlistTVSeries', () {
    test(
      'should change state to loading when usecase is called',
      () async {
        when(usecase.execute()).thenAnswer((_) async => Right([testTVSeries]));

        provider.fetchWatchlistTVSeries();

        expect(provider.state, RequestState.Loading);
      },
    );

    test(
      'should change list of tv series when data is gotten successfully',
      () async {
        when(usecase.execute()).thenAnswer((_) async => Right([testTVSeries]));

        await provider.fetchWatchlistTVSeries();

        expect(provider.state, RequestState.Loaded);
        expect(provider.tvSeries, [testTVSeries]);
      },
    );

    test(
      'should return error when usecase call is failed',
      () async {
        when(usecase.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        await provider.fetchWatchlistTVSeries();

        expect(provider.state, RequestState.Error);
        expect(provider.message, 'Server Failure');
      },
    );
  });
}
