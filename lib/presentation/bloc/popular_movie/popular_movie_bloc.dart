import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;

  PopularMovieBloc(this.getPopularMovies) : super(PopularMovieEmpty()) {
    on<OnFetchPopularMovie>((event, emit) async {
      emit(PopularMovieLoading());

      final result = await getPopularMovies.execute();

      result.fold(
        (failure) => emit(PopularMovieError(failure.message)),
        (data) => emit(PopularMovieLoaded(data)),
      );
    });
  }
}
