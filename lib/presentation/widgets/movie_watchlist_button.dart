import 'package:dicoding_ditonton/domain/entities/movie_detail.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieWatchlistButton extends StatelessWidget {
  final MovieDetail movie;
  const MovieWatchlistButton({required this.movie, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistMovieBloc, WatchlistMovieState>(
      listener: (context, state) {
        if (state is WatchlistMovieStatusLoaded) {
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
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, state) {
          var isAddedWatchlist = false;

          if (state is WatchlistMovieStatusLoaded) {
            isAddedWatchlist = state.status;
            return ElevatedButton(
              onPressed: () async {
                if (!isAddedWatchlist) {
                  context
                      .read<WatchlistMovieBloc>()
                      .add(AddWatchlistMovie(movie));
                } else {
                  context
                      .read<WatchlistMovieBloc>()
                      .add(RemoveWatchlistMovie(movie));
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
