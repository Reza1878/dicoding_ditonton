import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/search_tv_series.dart';
import 'package:dicoding_ditonton/presentation/bloc/utils.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTVSeries searchTVSeries;

  TvSeriesSearchBloc(this.searchTVSeries) : super(TvSeriesSearchInitial()) {
    on<OnQueryChanged>(
      (event, emit) async {
        emit(TVSeriesSearchLoading());
        final result = await searchTVSeries.execute(event.query);

        result.fold(
          (l) => emit(TVSeriesSearchError(l.message)),
          (r) => emit(TVSeriesSearchLoaded(r)),
        );
      },
      transformer: debounce(Duration(milliseconds: 1000)),
    );
  }
}
