part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object?> get props => [];
}

final class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieStatusLoaded extends WatchlistMovieState {
  final bool status;
  final String? message;
  WatchlistMovieStatusLoaded({required this.status, this.message});

  @override
  List<Object?> get props => [status, message];
}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMovieLoaded(this.result);
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;
  WatchlistMovieError(this.message);
}
