import 'dart:io';

import 'package:dicoding_ditonton/common/utils.dart';
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
import 'package:dicoding_ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // external
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback = (cert, host, port) => false;
  IOClient ioClient = IOClient(client);
  locator.registerLazySingleton<http.Client>(() => ioClient);

  locator.registerLazySingleton(() => NowPlayingMovieBloc(locator()));
  locator.registerLazySingleton(() => PopularMovieBloc(locator()));
  locator.registerLazySingleton(() => TopRatedMovieBloc(locator()));
  locator.registerLazySingleton(() => MovieSearchBloc(locator()));
  locator.registerLazySingleton(() => MovieDetailBloc(locator()));
  locator.registerLazySingleton(() => MovieRecommendationBloc(locator()));
  locator.registerLazySingleton(
    () => WatchlistMovieBloc(
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerLazySingleton(() => NowPlayingTvSeriesBloc(locator()));
  locator.registerLazySingleton(() => PopularTvSeriesBloc(locator()));
  locator.registerLazySingleton(() => TopRatedTvSeriesBloc(locator()));
  locator.registerLazySingleton(() => TvSeriesSearchBloc(locator()));
  locator.registerLazySingleton(() => TvSeriesDetailBloc(locator()));
  locator.registerLazySingleton(() => TvSeriesRecommendationBloc(locator()));
  locator.registerLazySingleton(
    () => WatchlistTvSeriesBloc(
      getWatchlistTVSeries: locator(),
      getTVSeriesWatchlistStatus: locator(),
      saveTVSeriesWatchlist: locator(),
      removeWatchlistTVSeries: locator(),
    ),
  );

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
    () => MovieRemoteDataSourceImpl(
      client: locator(),
    ),
  );
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
}
