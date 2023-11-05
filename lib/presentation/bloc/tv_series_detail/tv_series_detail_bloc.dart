import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTVSeriesDetail getTVSeriesDetail;

  TvSeriesDetailBloc(this.getTVSeriesDetail) : super(TvSeriesDetailInitial()) {
    on<OnFetchTVSeriesDetail>((event, emit) async {
      emit(TVSeriesDetailLoading());

      final result = await getTVSeriesDetail.execute(event.id);

      result.fold(
        (l) => emit(TVSeriesDetailError(l.message)),
        (r) => emit(TVSeriesDetailLoaded(r)),
      );
    });
  }
}
