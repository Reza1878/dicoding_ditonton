import 'package:dicoding_ditonton/data/datasources/db/database_helper.dart';
import 'package:dicoding_ditonton/data/datasources/movie_local_data_source.dart';
import 'package:dicoding_ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:dicoding_ditonton/data/datasources/tv_series_local_data_source.dart';
import 'package:dicoding_ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:dicoding_ditonton/data/repositories/movie_repository_impl.dart';
import 'package:dicoding_ditonton/data/repositories/tv_series_repository_impl.dart';
import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:dicoding_ditonton/domain/repositories/tv_series_repository.dart';
import 'package:dicoding_ditonton/domain/usecases/get_movie_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/get_now_playing_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_popular_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_recommendations.dart';
import 'package:dicoding_ditonton/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/remove_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_tv_series_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/save_watchlist.dart';
import 'package:dicoding_ditonton/domain/usecases/search_movies.dart';
import 'package:dicoding_ditonton/domain/usecases/search_tv_series.dart';
import 'package:dicoding_ditonton/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/popular_tv_series_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/top_rated_tv_series_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_now_playing_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_search_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerLazySingleton(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TVSeriesListNotifier(
      getNowPlayingTVSeries: locator(),
      getPopularTVSeries: locator(),
      getTopRatedTVSeries: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TVSeriesDetailNotifier(
      getTVSeriesDetail: locator(),
      getTVSeriesRecommendations: locator(),
      getTVSeriesWatchlistStatus: locator(),
      removeTVSeriesWatchlist: locator(),
      saveTVSeriesWatchlist: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => TVSeriesNowPlayingNotifier(
      locator(),
    ),
  );
  locator.registerLazySingleton(() => PopularTVSeriesNotifier(locator()));
  locator.registerLazySingleton(() => TopRatedTVSeriesNotifier(locator()));
  locator.registerLazySingleton(
    () => TVSeriesSearchNotifier(
      searchTVSeries: locator(),
    ),
  );
  locator.registerLazySingleton(
    () => WatchlistTVSeriesNotifier(
      getWatchlistTVSeries: locator(),
    ),
  );
  locator.registerLazySingleton(() => NowPlayingMovieBloc(locator()));
  locator.registerLazySingleton(() => PopularMovieBloc(locator()));
  locator.registerLazySingleton(() => TopRatedMovieBloc(locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetNowPlayingTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SaveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetTVSeriesWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
    () => TVSeriesRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
    () => TVSeriesLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
