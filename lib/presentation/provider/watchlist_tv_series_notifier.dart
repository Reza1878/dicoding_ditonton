import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:flutter/material.dart';

class WatchlistTVSeriesNotifier extends ChangeNotifier {
  final GetWatchlistTVSeries getWatchlistTVSeries;

  WatchlistTVSeriesNotifier({required this.getWatchlistTVSeries});

  List<TVSeries> _tvSeries = [];
  List<TVSeries> get tvSeries => _tvSeries;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> fetchWatchlistTVSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTVSeries.execute();

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _tvSeries = data;
        notifyListeners();
      },
    );
  }
}
