import 'package:dicoding_ditonton/domain/entities/tv_series_detail.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_tv_series/watchlist_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeriesWatchlistButton extends StatelessWidget {
  final TVSeriesDetail tvSeriesDetail;
  const TVSeriesWatchlistButton({super.key, required this.tvSeriesDetail});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
      listener: (context, state) {
        if (state is WatchlistTVSeriesStatusLoaded) {
          if (state.message != null) {
            final msg = state.message!;
            if (msg == 'Added to Watchlist' ||
                msg == 'Removed from Watchlist') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    msg,
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(msg),
                  );
                },
              );
            }
          }
        }
      },
      child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
        builder: (context, state) {
          var isAddedWatchlist = false;

          if (state is WatchlistTVSeriesStatusLoaded) {
            isAddedWatchlist = state.status;
            return ElevatedButton(
              onPressed: () async {
                if (!isAddedWatchlist) {
                  context
                      .read<WatchlistTvSeriesBloc>()
                      .add(AddWatchlistTVSeries(tvSeriesDetail));
                } else {
                  context
                      .read<WatchlistTvSeriesBloc>()
                      .add(OnRemoveWatchlistTVSeries(tvSeriesDetail));
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                  Text('Watchlist'),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
