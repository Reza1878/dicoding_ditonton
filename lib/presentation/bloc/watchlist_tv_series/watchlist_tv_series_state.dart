part of 'watchlist_tv_series_bloc.dart';

sealed class WatchlistTvSeriesState extends Equatable {
  const WatchlistTvSeriesState();

  @override
  List<Object?> get props => [];
}

final class WatchlistTvSeriesInitial extends WatchlistTvSeriesState {}

class WatchlistTVSeriesStatusLoaded extends WatchlistTvSeriesState {
  final bool status;
  final String? message;

  WatchlistTVSeriesStatusLoaded({required this.status, this.message});
  @override
  List<Object?> get props => [status, message];
}

class WatchlistTVSeriesLoading extends WatchlistTvSeriesState {}

class WatchlistTVSeriesLoaded extends WatchlistTvSeriesState {
  final List<TVSeries> result;
  WatchlistTVSeriesLoaded(this.result);
}

class WatchlistTVSeriesError extends WatchlistTvSeriesState {
  final String message;
  WatchlistTVSeriesError(this.message);
}
