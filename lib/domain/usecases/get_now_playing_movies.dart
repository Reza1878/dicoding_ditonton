import 'package:dartz/dartz.dart';
import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/domain/repositories/movie_repository.dart';
import 'package:dicoding_ditonton/common/failure.dart';

class GetNowPlayingMovies {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getNowPlayingMovies();
  }
}
