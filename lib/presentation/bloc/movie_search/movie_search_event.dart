part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChanged extends MovieSearchEvent {
  final String query;
  OnQueryChanged(this.query);
}
