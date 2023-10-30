import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:flutter/material.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  final GetTVSeriesWatchlistStatus getTVSeriesWatchlistStatus;
  final SaveTVSeriesWatchlist saveTVSeriesWatchlist;
  final RemoveTVSeriesWatchlist removeTVSeriesWatchlist;

  TVSeriesDetailNotifier({
    required this.getTVSeriesDetail,
    required this.getTVSeriesRecommendations,
    required this.getTVSeriesWatchlistStatus,
    required this.saveTVSeriesWatchlist,
    required this.removeTVSeriesWatchlist,
  });

  late TVSeriesDetail _tvSeries;
  TVSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<TVSeries> _recommendations = [];
  List<TVSeries> get recommendations => _recommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedToWatchlist = false;
  bool get isAddedToWatchlist => _isAddedToWatchlist;

  Future<void> fetchTVSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTVSeriesDetail.execute(id);
    final recommendationResult = await getTVSeriesRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeries) {
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();

        _tvSeries = tvSeries;
        notifyListeners();

        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
            notifyListeners();
          },
          (series) {
            _recommendationState = RequestState.Loaded;
            _recommendations = series;
            notifyListeners();
          },
        );
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVSeriesDetail tvSeriesDetail) async {
    final result = await saveTVSeriesWatchlist.execute(tvSeriesDetail);

    await result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (successMessage) {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail tvSeriesDetail) async {
    final result = await removeTVSeriesWatchlist.execute(tvSeriesDetail);

    await result.fold(
      (failure) {
        _watchlistMessage = failure.message;
      },
      (successMessage) {
        _watchlistMessage = successMessage;
      },
    );
    await loadWatchlistStatus(tvSeriesDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTVSeriesWatchlistStatus.execute(id);
    _isAddedToWatchlist = result;
    notifyListeners();
  }
}
