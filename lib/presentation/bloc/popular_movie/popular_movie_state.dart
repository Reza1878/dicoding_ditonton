part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieEmpty extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> result;

  PopularMovieLoaded(this.result);
}

class PopularMovieError extends PopularMovieState {
  final String message;

  PopularMovieError(this.message);
}
