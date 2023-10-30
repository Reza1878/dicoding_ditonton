import 'package:dicoding_ditonton/common/constants.dart';
import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/common/utils.dart';
import 'package:dicoding_ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:dicoding_ditonton/presentation/provider/watchlist_tv_series_notifier.dart';
import 'package:dicoding_ditonton/presentation/widgets/movie_card_list.dart';
import 'package:dicoding_ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies();
        Provider.of<WatchlistTVSeriesNotifier>(context, listen: false)
            .fetchWatchlistTVSeries();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTVSeriesNotifier>(context, listen: false)
        .fetchWatchlistTVSeries();
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
              Consumer<WatchlistMovieNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistState == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.watchlistState == RequestState.Loaded) {
                    if (data.watchlistMovies.isEmpty)
                      return Center(
                        child: Text('No data available'),
                      );
                    return ListView.builder(
                      shrinkWrap: true, // Use this to wrap content
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling
                      itemBuilder: (context, index) {
                        final movie = data.watchlistMovies[index];
                        return MovieCard(movie);
                      },
                      itemCount: data.watchlistMovies.length,
                    );
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'TV Series',
                style: kHeading6,
              ),
              Consumer<WatchlistTVSeriesNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    if (data.tvSeries.isEmpty)
                      return Center(
                        child: Text('No data available'),
                      );
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final tvSeries = data.tvSeries[index];
                        return TVSeriesCard(tvSeries);
                      },
                      itemCount: data.tvSeries.length,
                    );
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
                  }
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
