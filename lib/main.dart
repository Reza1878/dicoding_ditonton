import 'package:dicoding_ditonton/common/constants.dart';
import 'package:dicoding_ditonton/common/utils.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
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
import 'package:dicoding_ditonton/presentation/pages/about_page.dart';
import 'package:dicoding_ditonton/presentation/pages/movie_detail_page.dart';
import 'package:dicoding_ditonton/presentation/pages/home_movie_page.dart';
import 'package:dicoding_ditonton/presentation/pages/now_playing_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/pages/popular_movies_page.dart';
import 'package:dicoding_ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/pages/search_page.dart';
import 'package:dicoding_ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:dicoding_ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:dicoding_ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dicoding_ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<MovieSearchBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<MovieRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesSearchBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TvSeriesRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvSeriesBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case TVSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );
            case NowPlayingTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => NowPlayingTVSeriesPage(),
              );
            case TopRatedTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => TopRatedTVSeriesPage(),
              );
            case PopularTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => PopularTVSeriesPage(),
              );
            case SearchTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => SearchTVSeriesPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
