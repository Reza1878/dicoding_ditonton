part of 'tv_series_detail_bloc.dart';

sealed class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTVSeriesDetail extends TvSeriesDetailEvent {
  final int id;

  OnFetchTVSeriesDetail(this.id);
}
