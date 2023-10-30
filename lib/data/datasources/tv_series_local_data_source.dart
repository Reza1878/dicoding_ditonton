import 'package:dicoding_ditonton/common/exception.dart';
import 'package:dicoding_ditonton/data/datasources/db/database_helper.dart';
import 'package:dicoding_ditonton/data/models/tv_series_table.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertWatchlist(TVSeriesTable tvSeriesTable);
  Future<String> removeWatchlist(TVSeriesTable tvSeriesTable);
  Future<TVSeriesTable?> getTVSeriesById(int id);
  Future<List<TVSeriesTable>> getWatchlistTVSeries();
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;
  TVSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TVSeriesTable?> getTVSeriesById(int id) async {
    final result = await databaseHelper.getTVSeriesById(id);
    if (result == null) return null;
    return TVSeriesTable.fromMap(result);
  }

  @override
  Future<List<TVSeriesTable>> getWatchlistTVSeries() async {
    final result = await databaseHelper.getWatchlistTVSeries();
    return result.map((e) => TVSeriesTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchlist(TVSeriesTable tvSeriesTable) async {
    try {
      await databaseHelper.insertWatchlistTVSeries(tvSeriesTable);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TVSeriesTable tvSeriesTable) async {
    try {
      await databaseHelper.removeWatchlistTVSeries(tvSeriesTable);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
