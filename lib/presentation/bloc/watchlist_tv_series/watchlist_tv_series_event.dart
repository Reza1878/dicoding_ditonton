part of 'watchlist_tv_series_bloc.dart';

sealed class WatchlistTvSeriesEvent extends Equatable {
  const WatchlistTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class LoadWatchlistTVSeriesStatus extends WatchlistTvSeriesEvent {
  final int id;
  LoadWatchlistTVSeriesStatus(this.id);
}

class AddWatchlistTVSeries extends WatchlistTvSeriesEvent {
  final TVSeriesDetail tvSeriesDetail;
  AddWatchlistTVSeries(this.tvSeriesDetail);
}

class OnRemoveWatchlistTVSeries extends WatchlistTvSeriesEvent {
  final TVSeriesDetail tvSeriesDetail;
  OnRemoveWatchlistTVSeries(this.tvSeriesDetail);
}

class OnFetchWatchlistTVSeries extends WatchlistTvSeriesEvent {}
