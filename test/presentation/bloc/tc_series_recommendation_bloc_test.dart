import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/tv_series_detail_notifier_test.mocks.dart';

void main() {
  late MockGetTVSeriesRecommendations getTVSeriesRecommendations;
  late TvSeriesRecommendationBloc tvSeriesRecommendationBloc;

  setUp(() {
    getTVSeriesRecommendations = new MockGetTVSeriesRecommendations();
    tvSeriesRecommendationBloc =
        new TvSeriesRecommendationBloc(getTVSeriesRecommendations);
  });

  group('TVSeriesRecommendationBloc', () {
    final tId = 1;
    test('initial state should be TVSeriesRecommendationInitial', () {
      expect(tvSeriesRecommendationBloc.state, TvSeriesRecommendationInitial());
    });

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(getTVSeriesRecommendations.execute(tId)).thenAnswer(
            (realInvocation) =>
                Future.value(Left(ServerFailure('Server Failure'))));
        return tvSeriesRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVSeriesRecommendation(tId)),
      expect: () => [
        TVSeriesRecommendationLoading(),
        TVSeriesRecommendationError('Server Failure'),
      ],
      verify: (bloc) {
        verify(getTVSeriesRecommendations.execute(tId));
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(getTVSeriesRecommendations.execute(tId)).thenAnswer(
            (realInvocation) => Future.value(Right([testTVSeries])));
        return tvSeriesRecommendationBloc;
      },
      act: (bloc) => bloc.add(OnFetchTVSeriesRecommendation(tId)),
      expect: () => [
        TVSeriesRecommendationLoading(),
        TVSeriesRecommendationLoaded([testTVSeries]),
      ],
      verify: (bloc) {
        verify(getTVSeriesRecommendations.execute(tId));
      },
    );
  });
}
