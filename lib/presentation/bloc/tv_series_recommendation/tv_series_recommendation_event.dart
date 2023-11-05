part of 'tv_series_recommendation_bloc.dart';

sealed class TvSeriesRecommendationEvent extends Equatable {
  const TvSeriesRecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnFetchTVSeriesRecommendation extends TvSeriesRecommendationEvent {
  final int id;
  OnFetchTVSeriesRecommendation(this.id);
}
