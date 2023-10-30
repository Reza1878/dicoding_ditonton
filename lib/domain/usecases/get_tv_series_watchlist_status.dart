import 'package:dicoding_ditonton/domain/repositories/tv_series_repository.dart';

class GetTVSeriesWatchlistStatus {
  final TVSeriesRepository repository;

  GetTVSeriesWatchlistStatus(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlist(id);
  }
}
