import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/usecases/search_tv_series.dart';
import 'package:dicoding_ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late MockSearchTVSeries searchTVSeries;
  late TvSeriesSearchBloc tvSeriesSearchBloc;

  setUp(() {
    searchTVSeries = new MockSearchTVSeries();
    tvSeriesSearchBloc = new TvSeriesSearchBloc(searchTVSeries);
  });

  group('TVSeriesSearchBloc', () {
    final tQuery = "LOKI";
    test('initial state should be TVSeriesSearchInitial', () {
      expect(tvSeriesSearchBloc.state, TvSeriesSearchInitial());
    });

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(searchTVSeries.execute(tQuery)).thenAnswer((realInvocation) =>
            Future.value(Left(ServerFailure('Server Failure'))));
        return tvSeriesSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: Duration(milliseconds: 1000),
      expect: () =>
          [TVSeriesSearchLoading(), TVSeriesSearchError('Server Failure')],
      verify: (bloc) {
        verify(searchTVSeries.execute(tQuery));
      },
    );
    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(searchTVSeries.execute(tQuery)).thenAnswer(
            (realInvocation) => Future.value(Right([testTVSeries])));
        return tvSeriesSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: Duration(milliseconds: 1000),
      expect: () => [
        TVSeriesSearchLoading(),
        TVSeriesSearchLoaded([testTVSeries]),
      ],
      verify: (bloc) {
        verify(searchTVSeries.execute(tQuery));
      },
    );
  });
}
