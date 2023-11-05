part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchEmpty extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> result;

  MovieSearchLoaded(this.result);
}

class MovieSearchError extends MovieSearchState {
  final String message;

  MovieSearchError(this.message);
}
