import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieRecommendationBloc(this.getMovieRecommendations)
      : super(MovieRecommendationInitial()) {
    on<OnFetchMovieRecommendation>(
      (event, emit) async {
        emit(MovieRecommendationLoading());

        final result = await getMovieRecommendations.execute(event.id);

        result.fold(
          (failure) {
            emit(MovieRecommendationError(failure.message));
          },
          (data) {
            emit(MovieRecommendationLoaded(data));
          },
        );
      },
    );
  }
}
