import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_series_event.dart';
part 'now_playing_tv_series_state.dart';

class NowPlayingTvSeriesBloc
    extends Bloc<NowPlayingTvSeriesEvent, NowPlayingTvSeriesState> {
  final GetNowPlayingTVSeries getNowPlayingTVSeries;

  NowPlayingTvSeriesBloc(this.getNowPlayingTVSeries)
      : super(NowPlayingTvSeriesInitial()) {
    on<NowPlayingTvSeriesEvent>((event, emit) async {
      emit(NowPlayingTVSeriesLoading());

      final result = await getNowPlayingTVSeries.execute();

      result.fold(
        (failure) {
          emit(NowPlayingTVSeriesError(failure.message));
        },
        (data) {
          emit(NowPlayingTVSeriesLoaded(data));
        },
      );
    });
  }
}
