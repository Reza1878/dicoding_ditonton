import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/search_tv_series.dart';
import 'package:flutter/material.dart';

class TVSeriesSearchNotifier extends ChangeNotifier {
  final SearchTVSeries searchTVSeries;

  TVSeriesSearchNotifier({required this.searchTVSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TVSeries> _tvSeries = [];
  List<TVSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchTVSeries(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTVSeries.execute(query);

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
