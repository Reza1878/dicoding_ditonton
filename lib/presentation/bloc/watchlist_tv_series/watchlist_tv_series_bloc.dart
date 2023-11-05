import 'package:bloc/bloc.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchlistTVSeries getWatchlistTVSeries;
  final GetTVSeriesWatchlistStatus getTVSeriesWatchlistStatus;
  final SaveTVSeriesWatchlist saveTVSeriesWatchlist;
  final RemoveTVSeriesWatchlist removeWatchlistTVSeries;

  WatchlistTvSeriesBloc({
    required this.getWatchlistTVSeries,
    required this.getTVSeriesWatchlistStatus,
    required this.saveTVSeriesWatchlist,
    required this.removeWatchlistTVSeries,
  }) : super(WatchlistTvSeriesInitial()) {
    on<LoadWatchlistTVSeriesStatus>((event, emit) async {
      final result = await getTVSeriesWatchlistStatus.execute(event.id);
      emit(WatchlistTVSeriesStatusLoaded(status: result));
    });

    on<AddWatchlistTVSeries>((event, emit) async {
      final result = await saveTVSeriesWatchlist.execute(event.tvSeriesDetail);
      final status =
          await getTVSeriesWatchlistStatus.execute(event.tvSeriesDetail.id);

      result.fold(
        (l) => emit(
            WatchlistTVSeriesStatusLoaded(status: status, message: l.message)),
        (r) => emit(
          WatchlistTVSeriesStatusLoaded(
            status: status,
            message: 'Added to Watchlist',
          ),
        ),
      );
    });

    on<OnRemoveWatchlistTVSeries>(
      (event, emit) async {
        final result =
            await removeWatchlistTVSeries.execute(event.tvSeriesDetail);
        final status = await getTVSeriesWatchlistStatus.execute(
          event.tvSeriesDetail.id,
        );

        result.fold(
          (l) => emit(WatchlistTVSeriesStatusLoaded(
              status: status, message: l.message)),
          (r) => emit(
            WatchlistTVSeriesStatusLoaded(
              status: status,
              message: 'Removed from Watchlist',
            ),
          ),
        );
      },
    );

    on<OnFetchWatchlistTVSeries>(
      (event, emit) async {
        emit(WatchlistTVSeriesLoading());
        final result = await getWatchlistTVSeries.execute();
        result.fold(
          (l) => emit(WatchlistTVSeriesError(l.message)),
          (r) => emit(
            WatchlistTVSeriesLoaded(r),
          ),
        );
      },
    );
  }
}
