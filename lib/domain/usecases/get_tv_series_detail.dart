import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/common/failure.dart';
import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
