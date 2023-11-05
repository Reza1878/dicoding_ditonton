import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:dicoding_ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTVSeries])
void main() {
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late PopularTvSeriesBloc popularTvSeriesBloc;

  setUp(() {
    mockGetPopularTVSeries = new MockGetPopularTVSeries();
    popularTvSeriesBloc = new PopularTvSeriesBloc(mockGetPopularTVSeries);
  });

  group('PopularTVSeriesBloc', () {
    test(
      'initial state should be PopularTVSeriesInitial',
      () {
        expect(popularTvSeriesBloc.state, PopularTvSeriesInitial());
      },
    );

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer((realInvocation) =>
            Future.value(Left(ServerFailure('Server Failure'))));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTVSeries()),
      expect: () =>
          [PopularTVSeriesLoading(), PopularTVSeriesError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      },
    );

    blocTest(
      'should emit [Loading, Loading] when get data is success',
      build: () {
        when(mockGetPopularTVSeries.execute()).thenAnswer(
            (realInvocation) => Future.value(Right([testTVSeries])));
        return popularTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTVSeries()),
      expect: () => [
        PopularTVSeriesLoading(),
        PopularTVSeriesLoaded([testTVSeries])
      ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      },
    );
  });
}
