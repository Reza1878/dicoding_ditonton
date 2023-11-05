import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  final GetTopRatedTVSeries getTopRatedTVSeries;

  TopRatedTvSeriesBloc(this.getTopRatedTVSeries)
      : super(TopRatedTvSeriesInitial()) {
    on<TopRatedTvSeriesEvent>((event, emit) async {
      emit(TopRatedTVSeriesLoading());

      final result = await getTopRatedTVSeries.execute();

      result.fold(
        (failure) => emit(TopRatedTVSeriesError(failure.message)),
        (data) => emit(TopRatedTVSeriesLoaded(data)),
      );
    });
  }
}
