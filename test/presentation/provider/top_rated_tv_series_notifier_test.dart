import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:dicoding_ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_series_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TopRatedTVSeriesNotifier provider;

  setUp(() {
    mockGetTopRatedTVSeries = new MockGetTopRatedTVSeries();
    provider = new TopRatedTVSeriesNotifier(mockGetTopRatedTVSeries);
  });

  group('fetchTopRatedTVSeries', () {
    test('should change state to loading when usecase is called', () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right([testTVSeries]));

      provider.fetchTopRatedTVSeries();

      expect(provider.state, RequestState.Loading);
    });

    test(
      'should change tv series list when data is gotten successfully',
      () async {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right([testTVSeries]));

        await provider.fetchTopRatedTVSeries();

        expect(provider.tvSeries, [testTVSeries]);
        expect(provider.state, RequestState.Loaded);
      },
    );

    test('should change error message when usecase call is failed', () async {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Error')));

      await provider.fetchTopRatedTVSeries();

      expect(provider.message, 'Error');
      expect(provider.state, RequestState.Error);
    });
  });
}
