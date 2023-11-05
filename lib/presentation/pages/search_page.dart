import 'package:dicoding_ditonton/common/constants.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:dicoding_ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<MovieSearchBloc>().add(OnQueryChanged(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, data) {
                if (data is MovieSearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data is MovieSearchLoaded) {
                  final result = data.result;

                  if (result.isEmpty) {
                    return Center(
                      child: Text('No data available'),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = data.result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (data is MovieSearchError) {
                  return Center(
                    child: Text(data.message),
                  );
                }
                return Expanded(
                  child: Container(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
