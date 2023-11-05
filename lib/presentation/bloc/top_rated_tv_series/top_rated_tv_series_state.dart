part of 'top_rated_tv_series_bloc.dart';

sealed class TopRatedTvSeriesState extends Equatable {
  const TopRatedTvSeriesState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvSeriesInitial extends TopRatedTvSeriesState {}

class TopRatedTVSeriesLoading extends TopRatedTvSeriesState {}

class TopRatedTVSeriesLoaded extends TopRatedTvSeriesState {
  final List<TVSeries> result;

  TopRatedTVSeriesLoaded(this.result);
}

class TopRatedTVSeriesError extends TopRatedTvSeriesState {
  final String message;

  TopRatedTVSeriesError(this.message);
}
