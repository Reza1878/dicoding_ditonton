import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/entities/movie_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchlistMovies,
  }) : super(WatchlistMovieInitial()) {
    on<LoadWatchlistMovieStatus>(
      (event, emit) async {
        final result = await getWatchListStatus.execute(event.id);

        emit(WatchlistMovieStatusLoaded(status: result));
      },
    );

    on<AddWatchlistMovie>(
      (event, emit) async {
        final result = await saveWatchlist.execute(event.movieDetail);

        final status = await getWatchListStatus.execute(event.movieDetail.id);

        result.fold(
          (failure) => {
            emit(
              WatchlistMovieStatusLoaded(
                status: status,
                message: failure.message,
              ),
            )
          },
          (data) {
            emit(
              WatchlistMovieStatusLoaded(
                status: status,
                message: data,
              ),
            );
          },
        );
      },
    );

    on<RemoveWatchlistMovie>(
      (event, emit) async {
        final result = await removeWatchlist.execute(event.movieDetail);
        final status = await getWatchListStatus.execute(event.movieDetail.id);

        result.fold(
          (failure) {
            emit(
              WatchlistMovieStatusLoaded(
                status: status,
                message: failure.message,
              ),
            );
          },
          (data) {
            emit(
              WatchlistMovieStatusLoaded(
                status: status,
                message: data,
              ),
            );
          },
        );
      },
    );

    on<OnFetchWatchlistMovie>(
      (event, emit) async {
        emit(WatchlistMovieLoading());

        final result = await getWatchlistMovies.execute();

        result.fold(
          (failure) {
            emit(WatchlistMovieError(failure.message));
          },
          (data) {
            emit(WatchlistMovieLoaded(data));
          },
        );
      },
    );
  }
}
