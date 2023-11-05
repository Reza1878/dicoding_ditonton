import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:dicoding_ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieRecommendationList extends StatelessWidget {
  const MovieRecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
      builder: (context, data) {
        if (data is MovieRecommendationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data is MovieRecommendationError) {
          return Text(data.message);
        } else if (data is MovieRecommendationLoaded) {
          if (data.result.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }

          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = data.result[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: data.result.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
