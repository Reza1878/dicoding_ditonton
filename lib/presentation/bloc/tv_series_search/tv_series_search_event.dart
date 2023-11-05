part of 'tv_series_search_bloc.dart';

sealed class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends TvSeriesSearchEvent {
  final String query;
  OnQueryChanged(this.query);
}
