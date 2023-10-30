import 'package:dicoding_ditonton/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dicoding_ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TopRatedMovieBloc>().add(OnFetchTopRatedMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, data) {
            if (data is TopRatedMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is TopRatedMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.result[index];
                  return MovieCard(movie);
                },
                itemCount: data.result.length,
              );
            } else if (data is TopRatedMovieError) {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
            return Center(
              child: Text(''),
            );
          },
        ),
      ),
    );
  }
}
