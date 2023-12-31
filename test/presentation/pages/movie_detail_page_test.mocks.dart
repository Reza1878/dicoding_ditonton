// Mocks generated by Mockito 5.4.2 from annotations
// in dicoding_ditonton/test/presentation/pages/movie_detail_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;

import 'package:bloc/bloc.dart' as _i12;
import 'package:dicoding_ditonton/domain/usecases/get_movie_detail.dart' as _i2;
import 'package:dicoding_ditonton/domain/usecases/get_movie_recommendations.dart'
    as _i9;
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_movies.dart'
    as _i7;
import 'package:dicoding_ditonton/domain/usecases/get_watchlist_status.dart'
    as _i4;
import 'package:dicoding_ditonton/domain/usecases/remove_watchlist.dart' as _i6;
import 'package:dicoding_ditonton/domain/usecases/save_watchlist.dart' as _i5;
import 'package:dicoding_ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart'
    as _i3;
import 'package:dicoding_ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart'
    as _i10;
import 'package:dicoding_ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart'
    as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetMovieDetail_0 extends _i1.SmartFake
    implements _i2.GetMovieDetail {
  _FakeGetMovieDetail_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieDetailState_1 extends _i1.SmartFake
    implements _i3.MovieDetailState {
  _FakeMovieDetailState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchListStatus_2 extends _i1.SmartFake
    implements _i4.GetWatchListStatus {
  _FakeGetWatchListStatus_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSaveWatchlist_3 extends _i1.SmartFake implements _i5.SaveWatchlist {
  _FakeSaveWatchlist_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRemoveWatchlist_4 extends _i1.SmartFake
    implements _i6.RemoveWatchlist {
  _FakeRemoveWatchlist_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetWatchlistMovies_5 extends _i1.SmartFake
    implements _i7.GetWatchlistMovies {
  _FakeGetWatchlistMovies_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeWatchlistMovieState_6 extends _i1.SmartFake
    implements _i8.WatchlistMovieState {
  _FakeWatchlistMovieState_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetMovieRecommendations_7 extends _i1.SmartFake
    implements _i9.GetMovieRecommendations {
  _FakeGetMovieRecommendations_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieRecommendationState_8 extends _i1.SmartFake
    implements _i10.MovieRecommendationState {
  _FakeMovieRecommendationState_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailBloc extends _i1.Mock implements _i3.MovieDetailBloc {
  MockMovieDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieDetail get getMovieDetail => (super.noSuchMethod(
        Invocation.getter(#getMovieDetail),
        returnValue: _FakeGetMovieDetail_0(
          this,
          Invocation.getter(#getMovieDetail),
        ),
      ) as _i2.GetMovieDetail);

  @override
  _i3.MovieDetailState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieDetailState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.MovieDetailState);

  @override
  _i11.Stream<_i3.MovieDetailState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i11.Stream<_i3.MovieDetailState>.empty(),
      ) as _i11.Stream<_i3.MovieDetailState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i3.MovieDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i3.MovieDetailEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.MovieDetailState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i3.MovieDetailEvent>(
    _i12.EventHandler<E, _i3.MovieDetailState>? handler, {
    _i12.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i12.Transition<_i3.MovieDetailEvent, _i3.MovieDetailState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i11.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);

  @override
  void onChange(_i12.Change<_i3.MovieDetailState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [WatchlistMovieBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistMovieBloc extends _i1.Mock
    implements _i8.WatchlistMovieBloc {
  MockWatchlistMovieBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.GetWatchListStatus get getWatchListStatus => (super.noSuchMethod(
        Invocation.getter(#getWatchListStatus),
        returnValue: _FakeGetWatchListStatus_2(
          this,
          Invocation.getter(#getWatchListStatus),
        ),
      ) as _i4.GetWatchListStatus);

  @override
  _i5.SaveWatchlist get saveWatchlist => (super.noSuchMethod(
        Invocation.getter(#saveWatchlist),
        returnValue: _FakeSaveWatchlist_3(
          this,
          Invocation.getter(#saveWatchlist),
        ),
      ) as _i5.SaveWatchlist);

  @override
  _i6.RemoveWatchlist get removeWatchlist => (super.noSuchMethod(
        Invocation.getter(#removeWatchlist),
        returnValue: _FakeRemoveWatchlist_4(
          this,
          Invocation.getter(#removeWatchlist),
        ),
      ) as _i6.RemoveWatchlist);

  @override
  _i7.GetWatchlistMovies get getWatchlistMovies => (super.noSuchMethod(
        Invocation.getter(#getWatchlistMovies),
        returnValue: _FakeGetWatchlistMovies_5(
          this,
          Invocation.getter(#getWatchlistMovies),
        ),
      ) as _i7.GetWatchlistMovies);

  @override
  _i8.WatchlistMovieState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeWatchlistMovieState_6(
          this,
          Invocation.getter(#state),
        ),
      ) as _i8.WatchlistMovieState);

  @override
  _i11.Stream<_i8.WatchlistMovieState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i11.Stream<_i8.WatchlistMovieState>.empty(),
      ) as _i11.Stream<_i8.WatchlistMovieState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i8.WatchlistMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i8.WatchlistMovieEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i8.WatchlistMovieState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i8.WatchlistMovieEvent>(
    _i12.EventHandler<E, _i8.WatchlistMovieState>? handler, {
    _i12.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i12.Transition<_i8.WatchlistMovieEvent, _i8.WatchlistMovieState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i11.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);

  @override
  void onChange(_i12.Change<_i8.WatchlistMovieState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [MovieRecommendationBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieRecommendationBloc extends _i1.Mock
    implements _i10.MovieRecommendationBloc {
  MockMovieRecommendationBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i9.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(
        Invocation.getter(#getMovieRecommendations),
        returnValue: _FakeGetMovieRecommendations_7(
          this,
          Invocation.getter(#getMovieRecommendations),
        ),
      ) as _i9.GetMovieRecommendations);

  @override
  _i10.MovieRecommendationState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieRecommendationState_8(
          this,
          Invocation.getter(#state),
        ),
      ) as _i10.MovieRecommendationState);

  @override
  _i11.Stream<_i10.MovieRecommendationState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i11.Stream<_i10.MovieRecommendationState>.empty(),
      ) as _i11.Stream<_i10.MovieRecommendationState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i10.MovieRecommendationEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i10.MovieRecommendationEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i10.MovieRecommendationState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i10.MovieRecommendationEvent>(
    _i12.EventHandler<E, _i10.MovieRecommendationState>? handler, {
    _i12.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i12.Transition<_i10.MovieRecommendationEvent,
                  _i10.MovieRecommendationState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i11.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);

  @override
  void onChange(_i12.Change<_i10.MovieRecommendationState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
