import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTVSeries getPopularTVSeries;

  PopularTvSeriesBloc(this.getPopularTVSeries)
      : super(PopularTvSeriesInitial()) {
    on<PopularTvSeriesEvent>((event, emit) async {
      emit(PopularTVSeriesLoading());

      final result = await getPopularTVSeries.execute();

      result.fold(
        (failure) => emit(PopularTVSeriesError(failure.message)),
        (data) => emit(PopularTVSeriesLoaded(data)),
      );
    });
  }
}
