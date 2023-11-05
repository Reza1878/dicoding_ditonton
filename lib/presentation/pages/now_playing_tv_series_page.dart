import 'package:dicoding_ditonton/presentation/bloc/now_playing_tv_series/now_playing_tv_series_bloc.dart';
import 'package:dicoding_ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series/now-playing';

  @override
  _NowPlayingTVSeriesPageState createState() => _NowPlayingTVSeriesPageState();
}

class _NowPlayingTVSeriesPageState extends State<NowPlayingTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<NowPlayingTvSeriesBloc>()
        .add(OnFetchNowPlayingTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing (TV Series)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayingTvSeriesBloc, NowPlayingTvSeriesState>(
          builder: (context, data) {
            final state = data;

            if (state is NowPlayingTVSeriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingTVSeriesLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvSeries = state.result[index];
                  return TVSeriesCard(tvSeries);
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayingTVSeriesError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
