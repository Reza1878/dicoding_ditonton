import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/usecases/get_popular_movies.dart';
import 'package:dicoding_ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc popularMovieBloc;

  setUp(() {
    mockGetPopularMovies = new MockGetPopularMovies();
    popularMovieBloc = new PopularMovieBloc(mockGetPopularMovies);
  });

  group('PopularMovieBloc', () {
    test('initial state should be empty', () {
      expect(popularMovieBloc.state, PopularMovieEmpty());
    });

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));
        return popularMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieLoaded([testMovie]),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
