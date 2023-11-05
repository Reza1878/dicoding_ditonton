part of 'watchlist_movie_bloc.dart';

sealed class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistMovieStatus extends WatchlistMovieEvent {
  final int id;

  LoadWatchlistMovieStatus(this.id);
}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  AddWatchlistMovie(this.movieDetail);
}

class RemoveWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  RemoveWatchlistMovie(this.movieDetail);
}

class OnFetchWatchlistMovie extends WatchlistMovieEvent {}
