import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:dicoding_ditonton/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMovieBloc nowPlayingMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = new MockGetNowPlayingMovies();
    nowPlayingMovieBloc = new NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  group('NowPlayingMovieBloc', () {
    test('initial state should be empty', () {
      expect(nowPlayingMovieBloc.state, NowPlayingMovieEmpty());
    });

    blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
      'should emit [Loading, Error] when get data is failed',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovie()),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest(
      'should emit [Loading, Loaded] when get data is success',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right([testMovie]));

        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovie()),
      expect: () => [
        NowPlayingMovieLoading(),
        NowPlayingMovieLoaded([testMovie])
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
