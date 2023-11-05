import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_search_notifier_test.mocks.dart';

void main() {
  late MockSearchMovies mockSearchMovies;
  late MovieSearchBloc movieSearchBloc;

  setUp(() {
    mockSearchMovies = new MockSearchMovies();
    movieSearchBloc = new MovieSearchBloc(mockSearchMovies);
  });

  group('MovieSearchBloc', () {
    final tQuery = "LOKI";
    test(
      'initial data should be empty',
      () {
        expect(movieSearchBloc.state, MovieSearchEmpty());
      },
    );

    blocTest(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 1000),
      expect: () => [MovieSearchLoading(), MovieSearchError('Server Failure')],
      verify: (bloc) {
        verify(
          mockSearchMovies.execute(tQuery),
        );
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right([testMovie]));

        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(milliseconds: 1000),
      expect: () => [
        MovieSearchLoading(),
        MovieSearchLoaded([testMovie]),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
