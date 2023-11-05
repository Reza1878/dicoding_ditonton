import 'package:dicoding_ditonton/common/constants.dart';
import 'package:dicoding_ditonton/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/top_rated_tv_series/top_rated_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/pages/now_playing_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/pages/popular_movies_page.dart';
import 'package:dicoding_ditonton/presentation/pages/popular_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/pages/search_page.dart';
import 'package:dicoding_ditonton/presentation/pages/search_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:dicoding_ditonton/presentation/pages/top_rated_tv_series_page.dart';
import 'package:dicoding_ditonton/presentation/widgets/movie_list.dart';
import 'package:dicoding_ditonton/presentation/widgets/my_drawer.dart';
import 'package:dicoding_ditonton/presentation/widgets/tv_series_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NowPlayingMovieBloc>().add(OnFetchNowPlayingMovie());
      context.read<TopRatedMovieBloc>().add(OnFetchTopRatedMovie());
      context.read<PopularMovieBloc>().add(OnFetchPopularMovie());
      context.read<NowPlayingTvSeriesBloc>().add(OnFetchNowPlayingTvSeries());
      context.read<TopRatedTvSeriesBloc>().add(OnFetchTopRatedTVSeries());
      context.read<PopularTvSeriesBloc>().add(OnFetchPopularTVSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(activeRoute: 'Movies'),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                  builder: (context, data) {
                final state = data;
                if (state is NowPlayingMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is NowPlayingMovieLoaded) {
                  return MovieList(state.result);
                }
                return Text('Failed');
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMovieBloc, PopularMovieState>(
                  builder: (context, data) {
                final state = data;
                if (state is PopularMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMovieLoaded) {
                  return MovieList(state.result);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                  builder: (context, data) {
                final state = data;
                if (state is TopRatedMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMovieLoaded) {
                  return MovieList(state.result);
                } else {
                  return Text('Failed');
                }
              }),
              SizedBox(
                height: 48,
              ),
              _buildSubHeading(
                title: 'Now Playing (TV Series)',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    NowPlayingTVSeriesPage.ROUTE_NAME,
                  );
                },
              ),
              BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
                builder: (context, data) {
                  final state = data;
                  if (state is NowPlayingTVSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowPlayingTVSeriesLoaded) {
                    return TVSeriesList(state.result);
                  } else if (state is NowPlayingTVSeriesError) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
              _buildSubHeading(
                title: 'Popular (TV Series)',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PopularTVSeriesPage.ROUTE_NAME,
                  );
                },
              ),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (context, data) {
                  final state = data;
                  if (state is PopularTVSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTVSeriesLoaded) {
                    return TVSeriesList(state.result);
                  } else if (state is PopularTVSeriesError) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
              _buildSubHeading(
                title: 'Top Rated (TV Series)',
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    TopRatedTVSeriesPage.ROUTE_NAME,
                  );
                },
              ),
              BlocBuilder<TopRatedTvSeriesBloc, TopRatedTvSeriesState>(
                builder: (context, data) {
                  final state = data;
                  if (state is TopRatedTVSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedTVSeriesLoaded) {
                    return TVSeriesList(state.result);
                  } else if (state is TopRatedTVSeriesError) {
                    return Text(state.message);
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchTVSeriesPage.ROUTE_NAME);
                  },
                  child: Text('Search TV Series'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
