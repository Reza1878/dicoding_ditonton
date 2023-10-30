import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_list_notifier_test.mocks.dart';

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc topRatedMovieBloc;

  setUp(() {
    mockGetTopRatedMovies = new MockGetTopRatedMovies();
    topRatedMovieBloc = new TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  group('TopRatedMovieBloc', () {
    test('initial state should be empty', () {
      expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
    });

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovie()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedMovie()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieLoaded([testMovie])
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
