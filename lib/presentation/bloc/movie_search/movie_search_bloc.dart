import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/usecases/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/utils.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;

  MovieSearchBloc(this.searchMovies) : super(MovieSearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        emit(MovieSearchLoading());

        final result = await searchMovies.execute(event.query);

        result.fold(
          (failure) {
            emit(MovieSearchError(failure.message));
          },
          (data) {
            emit(MovieSearchLoaded(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 1000),
      ),
    );
  }
}
