import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_watchlist.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_move_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchlistMovies,
])
void main() {
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockGetWatchListStatus = new MockGetWatchListStatus();
    mockSaveWatchlist = new MockSaveWatchlist();
    mockRemoveWatchlist = new MockRemoveWatchlist();
    mockGetWatchlistMovies = new MockGetWatchlistMovies();
    watchlistMovieBloc = new WatchlistMovieBloc(
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
      getWatchlistMovies: mockGetWatchlistMovies,
    );
  });

  group('WatchlistMovieBloc', () {
    test('initial state should be WatchlistMovieInitial', () {
      expect(watchlistMovieBloc.state, WatchlistMovieInitial());
    });

    group('LoadWatchlistMovieStatus', () {
      final tId = 1;
      blocTest(
        'should emit [Loaded] with status false if movie is not in watchlist',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => false);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistMovieStatus(tId)),
        expect: () => [
          WatchlistMovieStatusLoaded(status: false),
        ],
        verify: (bloc) {
          mockGetWatchListStatus.execute(tId);
        },
      );

      blocTest(
        'should emit [Loaded] with status false if movie is in watchlist',
        build: () {
          when(mockGetWatchListStatus.execute(tId))
              .thenAnswer((_) async => true);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(LoadWatchlistMovieStatus(tId)),
        expect: () => [
          WatchlistMovieStatusLoaded(status: true),
        ],
        verify: (bloc) {
          mockGetWatchListStatus.execute(tId);
        },
      );
    });

    group('AddWatchlistMovie', () {
      blocTest(
        'should emit [Loaded] with error message when add watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));

          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);

          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
        expect: () => [
          WatchlistMovieStatusLoaded(
            status: false,
            message: 'Database Failure',
          ),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );

      blocTest(
        'should emit [Loaded] with success message when add watchlist success',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Added to Watchlist'));

          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);

          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(AddWatchlistMovie(testMovieDetail)),
        expect: () => [
          WatchlistMovieStatusLoaded(
            status: true,
            message: 'Added to Watchlist',
          ),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );
    });

    group('RemoveWatchlistMovie', () {
      blocTest(
        'should emit [Loaded] with error message when remove watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));

          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);

          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
        expect: () => [
          WatchlistMovieStatusLoaded(
            status: true,
            message: 'Database Failure',
          ),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );

      blocTest(
        'should emit [Loaded] with success message when remove watchlist success',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => Right('Removed from Watchlist'));

          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);

          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
        expect: () => [
          WatchlistMovieStatusLoaded(
            status: false,
            message: 'Removed from Watchlist',
          ),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
        },
      );
    });

    group(
      'OnFetchWatchlistMovies',
      () {
        blocTest(
          'should emit [Loading, Error] when get data is failed',
          build: () {
            when(mockGetWatchlistMovies.execute()).thenAnswer(
                (_) async => Left(DatabaseFailure('Database Failure')));
            return watchlistMovieBloc;
          },
          act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
          expect: () => [
            WatchlistMovieLoading(),
            WatchlistMovieError('Database Failure'),
          ],
          verify: (bloc) {
            verify(mockGetWatchlistMovies.execute());
          },
        );

        blocTest(
          'should emit [Loading, Loaded] when get data is success',
          build: () {
            when(mockGetWatchlistMovies.execute())
                .thenAnswer((_) async => Right([testMovie]));

            return watchlistMovieBloc;
          },
          act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
          expect: () => [
            WatchlistMovieLoading(),
            WatchlistMovieLoaded([testMovie]),
          ],
          verify: (bloc) {
            verify(mockGetWatchlistMovies.execute());
          },
        );
      },
    );
  });
}
