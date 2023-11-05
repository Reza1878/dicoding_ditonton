part of 'tv_series_detail_bloc.dart';

sealed class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

final class TvSeriesDetailInitial extends TvSeriesDetailState {}

class TVSeriesDetailLoading extends TvSeriesDetailState {}

class TVSeriesDetailLoaded extends TvSeriesDetailState {
  final TVSeriesDetail tvSeriesDetail;

  TVSeriesDetailLoaded(this.tvSeriesDetail);
}

class TVSeriesDetailError extends TvSeriesDetailState {
  final String message;

  TVSeriesDetailError(this.message);
}
