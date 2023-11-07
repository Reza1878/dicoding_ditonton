import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:dicoding_ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'top_rated_tv_series_bloc_test.mocks.dart';

import '../../dummy_data/dummy_objects.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TopRatedTvSeriesBloc topRatedTvSeriesBloc;

  setUp(() {
    mockGetTopRatedTVSeries = new MockGetTopRatedTVSeries();
    topRatedTvSeriesBloc = new TopRatedTvSeriesBloc(mockGetTopRatedTVSeries);
  });

  group('TopRatedTVSeriesBloc', () {
    test('initial state should be TopRatedTVSeriesInitial', () {
      expect(topRatedTvSeriesBloc.state, TopRatedTvSeriesInitial());
    });

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer((realInvocation) =>
            Future.value(Left(ServerFailure('Server Failure'))));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTVSeries()),
      expect: () => [
        TopRatedTVSeriesLoading(),
        TopRatedTVSeriesError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      },
    );
    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(mockGetTopRatedTVSeries.execute()).thenAnswer(
            (realInvocation) => Future.value(Right([testTVSeries])));
        return topRatedTvSeriesBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTVSeries()),
      expect: () => [
        TopRatedTVSeriesLoading(),
        TopRatedTVSeriesLoaded([testTVSeries]),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      },
    );
  });
}
