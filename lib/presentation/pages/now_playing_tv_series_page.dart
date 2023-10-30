import 'package:dicoding_ditonton/common/state_enum.dart';
import 'package:dicoding_ditonton/presentation/provider/tv_series_now_playing_notifier.dart';
import 'package:dicoding_ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/now-playing';

  @override
  _NowPlayingTVSeriesPageState createState() => _NowPlayingTVSeriesPageState();
}

class _NowPlayingTVSeriesPageState extends State<NowPlayingTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TVSeriesNowPlayingNotifier>(context, listen: false)
            .fetchNowPlayingTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing (TV Series)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TVSeriesNowPlayingNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
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
      ),
    );
  }
}
