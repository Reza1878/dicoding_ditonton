import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/usecases/search_tv_series.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late MockSearchTVSeries usecase;
  late TVSeriesSearchNotifier provider;

  setUp(() {
    usecase = new MockSearchTVSeries();
    provider = new TVSeriesSearchNotifier(searchTVSeries: usecase);
  });

  group('fetchSearchTVSeries', () {
    final tQuery = 'LOKI';

    test(
      'should change state to loading when usecase is called',
      () async {
        when(usecase.execute(tQuery))
            .thenAnswer((_) async => Right([testTVSeries]));

        provider.fetchSearchTVSeries(tQuery);

        expect(provider.state, RequestState.Loading);
      },
    );

    test(
      'should change list of tv series when data is gotten successfully',
      () async {
        when(usecase.execute(tQuery))
            .thenAnswer((_) async => Right([testTVSeries]));

        await provider.fetchSearchTVSeries(tQuery);

        expect(provider.state, RequestState.Loaded);
        expect(provider.tvSeries, [testTVSeries]);
      },
    );

    test(
      'should return error when usecase call is failed',
      () async {
        when(usecase.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        await provider.fetchSearchTVSeries(tQuery);

        expect(provider.state, RequestState.Error);
        expect(provider.message, 'Server Failure');
      },
    );
  });
}
