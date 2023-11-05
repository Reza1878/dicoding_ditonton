import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationBloc movieRecommendationBloc;

  setUp(() {
    mockGetMovieRecommendations = new MockGetMovieRecommendations();
    movieRecommendationBloc = new MovieRecommendationBloc(
      mockGetMovieRecommendations,
    );
  });

  group(
    'MovieRecommendationBloc',
    () {
      final tId = 1;
      test(
        'initial state should be MovieRecommendationInitial',
        () {
          expect(movieRecommendationBloc.state, MovieRecommendationInitial());
        },
      );

      blocTest(
        'should emit [Loading, Error] when get data is failed',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

          return movieRecommendationBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendation(tId)),
        expect: () => [
          MovieRecommendationLoading(),
          MovieRecommendationError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        },
      );

      blocTest(
        'should emit [Loading, Loaded] when get data is success',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right([testMovie]));
          return movieRecommendationBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieRecommendation(tId)),
        expect: () => [
          MovieRecommendationLoading(),
          MovieRecommendationLoaded([testMovie]),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        },
      );
    },
  );
}
