part of 'tv_series_recommendation_bloc.dart';

sealed class TvSeriesRecommendationState extends Equatable {
  const TvSeriesRecommendationState();

  @override
  List<Object> get props => [];
}

final class TvSeriesRecommendationInitial extends TvSeriesRecommendationState {}

class TVSeriesRecommendationLoading extends TvSeriesRecommendationState {}

class TVSeriesRecommendationLoaded extends TvSeriesRecommendationState {
  final List<TVSeries> result;
  TVSeriesRecommendationLoaded(this.result);
}

class TVSeriesRecommendationError extends TvSeriesRecommendationState {
  final String message;
  TVSeriesRecommendationError(this.message);
}
