part of 'tv_series_search_bloc.dart';

sealed class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object> get props => [];
}

final class TvSeriesSearchInitial extends TvSeriesSearchState {}

class TVSeriesSearchLoading extends TvSeriesSearchState {}

class TVSeriesSearchLoaded extends TvSeriesSearchState {
  final List<TVSeries> result;
  TVSeriesSearchLoaded(this.result);
}

class TVSeriesSearchError extends TvSeriesSearchState {
  final String message;
  TVSeriesSearchError(this.message);
}
