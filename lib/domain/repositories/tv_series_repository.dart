import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getNowPlayingTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeriesDetail);
  Future<Either<Failure, String>> removeWatchlist(
    TVSeriesDetail tvSeriesDetail,
  );
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TVSeries>>> getWatchlistTVSeries();
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query);
}
