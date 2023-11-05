part of 'now_playing_tv_series_bloc.dart';

sealed class NowPlayingTvSeriesState extends Equatable {
  const NowPlayingTvSeriesState();

  @override
  List<Object> get props => [];
}

final class NowPlayingTvSeriesInitial extends NowPlayingTvSeriesState {}

class NowPlayingTVSeriesLoading extends NowPlayingTvSeriesState {}

class NowPlayingTVSeriesLoaded extends NowPlayingTvSeriesState {
  final List<TVSeries> result;

  NowPlayingTVSeriesLoaded(this.result);
}

class NowPlayingTVSeriesError extends NowPlayingTvSeriesState {
  final String message;

  NowPlayingTVSeriesError(this.message);
}
