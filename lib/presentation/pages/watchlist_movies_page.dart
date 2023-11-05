import 'package:dicoding_ditonton/common/constants.dart';
import 'package:dicoding_ditonton/common/utils.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/widgets/movie_card_list.dart';
import 'package:dicoding_ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        context.read<WatchlistMovieBloc>().add(OnFetchWatchlistMovie());
        context.read<WatchlistTvSeriesBloc>().add(OnFetchWatchlistTVSeries());
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnFetchWatchlistMovie());
    context.read<WatchlistTvSeriesBloc>().add(OnFetchWatchlistTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movies',
                style: kHeading6,
              ),
              BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                builder: (context, data) {
                  if (data is WatchlistMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data is WatchlistMovieLoaded) {
                    if (data.result.isEmpty)
                      return Center(
                        child: Text('No data available'),
                      );
                    return ListView.builder(
                      shrinkWrap: true, // Use this to wrap content
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling
                      itemBuilder: (context, index) {
                        final movie = data.result[index];
                        return MovieCard(movie);
                      },
                      itemCount: data.result.length,
                    );
                  } else if (data is WatchlistMovieError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                  return Center(
                    child: Text('No data available'),
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'TV Series',
                style: kHeading6,
              ),
              BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
                builder: (context, data) {
                  if (data is WatchlistTVSeriesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data is WatchlistTVSeriesLoaded) {
                    if (data.result.isEmpty)
                      return Center(
                        child: Text('No data available'),
                      );
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final tvSeries = data.result[index];
                        return TVSeriesCard(tvSeries);
                      },
                      itemCount: data.result.length,
                    );
                  } else if (data is WatchlistTVSeriesError) {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
