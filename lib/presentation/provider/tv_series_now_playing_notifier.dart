import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:flutter/material.dart';

class TVSeriesNowPlayingNotifier extends ChangeNotifier {
  final GetNowPlayingTVSeries getNowPlayingTVSeries;

  TVSeriesNowPlayingNotifier(this.getNowPlayingTVSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVSeries> _tvSeries = [];
  List<TVSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlayingTVSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTVSeries.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (data) {
      _tvSeries = data;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
