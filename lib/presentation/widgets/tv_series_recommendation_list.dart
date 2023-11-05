import 'package:cached_network_image/cached_network_image.dart';
import 'package:dicoding_ditonton/presentation/bloc/tv_series_recommendation/tv_series_recommendation_bloc.dart';
import 'package:dicoding_ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSeriesRecommendationList extends StatelessWidget {
  const TVSeriesRecommendationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvSeriesRecommendationBloc, TvSeriesRecommendationState>(
      builder: (context, data) {
        if (data is TVSeriesRecommendationLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (data is TVSeriesRecommendationError) {
          return Text(data.message);
        } else if (data is TVSeriesRecommendationLoaded) {
          final recommendations = data.result;

          if (recommendations.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          }

          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final curr = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        TVSeriesDetailPage.ROUTE_NAME,
                        arguments: curr.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${curr.posterPath}',
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
