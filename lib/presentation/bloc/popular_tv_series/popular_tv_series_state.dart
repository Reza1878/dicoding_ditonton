part of 'popular_tv_series_bloc.dart';

sealed class PopularTvSeriesState extends Equatable {
  const PopularTvSeriesState();

  @override
  List<Object> get props => [];
}

final class PopularTvSeriesInitial extends PopularTvSeriesState {}

class PopularTVSeriesLoading extends PopularTvSeriesState {}

class PopularTVSeriesLoaded extends PopularTvSeriesState {
  final List<TVSeries> result;

  PopularTVSeriesLoaded(this.result);
}

class PopularTVSeriesError extends PopularTvSeriesState {
  final String message;
  PopularTVSeriesError(this.message);
}
