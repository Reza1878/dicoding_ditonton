import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  var _nowPlaying = <TVSeries>[];
  List<TVSeries> get nowPlaying => _nowPlaying;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  var _popular = <TVSeries>[];
  List<TVSeries> get popular => _popular;

  RequestState _popularState = RequestState.Empty;
  RequestState get popularState => _popularState;

  var _topRated = <TVSeries>[];
  List<TVSeries> get topRated => _topRated;

  RequestState _topRatedState = RequestState.Empty;
  RequestState get topRatedState => _topRatedState;

  String _message = '';
  String get message => _message;

  TVSeriesListNotifier({
    required this.getNowPlayingTVSeries,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  });

  final GetNowPlayingTVSeries getNowPlayingTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;

  Future<void> fetchNowPlaying() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTVSeries.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlaying =
            data.where((element) => element.posterPath != null).toList();
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopular() async {
    _popularState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold(
      (failure) {
        _popularState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _popularState = RequestState.Loaded;
        _popular = data.where((element) => element.posterPath != null).toList();
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRated() async {
    _topRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold(
      (failure) {
        _topRatedState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _topRatedState = RequestState.Loaded;
        _topRated =
            data.where((element) => element.posterPath != null).toList();
        notifyListeners();
      },
    );
  }
}
