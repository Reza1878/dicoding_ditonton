part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationState extends Equatable {
  const MovieRecommendationState();

  @override
  List<Object> get props => [];
}

final class MovieRecommendationInitial extends MovieRecommendationState {}

class MovieRecommendationLoading extends MovieRecommendationState {}

class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Movie> result;

  MovieRecommendationLoaded(this.result);
}

class MovieRecommendationError extends MovieRecommendationState {
  final String message;
  MovieRecommendationError(this.message);
}
