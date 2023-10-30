import 'package:dicoding_ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dicoding_ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<PopularMovieBloc>().add(OnFetchPopularMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, data) {
            if (data is PopularMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data is PopularMovieLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.result[index];
                  return MovieCard(movie);
                },
                itemCount: data.result.length,
              );
            } else if (data is PopularMovieError) {
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
