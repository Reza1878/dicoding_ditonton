import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_recommendation_event.dart';
part 'tv_series_recommendation_state.dart';

class TvSeriesRecommendationBloc
    extends Bloc<TvSeriesRecommendationEvent, TvSeriesRecommendationState> {
  final GetTVSeriesRecommendations getTVSeriesRecommendations;

  TvSeriesRecommendationBloc(this.getTVSeriesRecommendations)
      : super(TvSeriesRecommendationInitial()) {
    on<OnFetchTVSeriesRecommendation>((event, emit) async {
      emit(TVSeriesRecommendationLoading());
      final result = await getTVSeriesRecommendations.execute(event.id);

      result.fold(
        (l) => emit(TVSeriesRecommendationError(l.message)),
        (r) => emit(TVSeriesRecommendationLoaded(r)),
      );
    });
  }
}
