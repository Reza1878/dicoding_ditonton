import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_series_repository.dart';

class RemoveTVSeriesWatchlist {
  final TVSeriesRepository repository;

  RemoveTVSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail tvSeriesDetail) {
    return repository.removeWatchlist(tvSeriesDetail);
  }
}
