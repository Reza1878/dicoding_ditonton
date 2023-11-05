import 'package:dicoding_ditonton/domain/entities/movie.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:dicoding_ditonton/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:dicoding_ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, WatchlistMovieBloc, MovieRecommendationBloc])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;

  setUp(() {
    mockMovieDetailBloc = new MockMovieDetailBloc();
    mockWatchlistMovieBloc = new MockWatchlistMovieBloc();
    mockMovieRecommendationBloc = new MockMovieRecommendationBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (_) => mockMovieDetailBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => mockWatchlistMovieBloc,
        ),
        BlocProvider<MovieRecommendationBloc>(
          create: (_) => mockMovieRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  _listenStream() {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockMovieRecommendationBloc.stream).thenAnswer((_) => Stream.empty());
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    _listenStream();

    when(mockMovieDetailBloc.state).thenReturn(
      MovieDetailLoaded(testMovieDetail),
    );
    when(mockMovieRecommendationBloc.state).thenReturn(
      MovieRecommendationLoaded(<Movie>[]),
    );
    when(mockWatchlistMovieBloc.state).thenReturn(
      WatchlistMovieStatusLoaded(status: false),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    _listenStream();

    when(mockMovieDetailBloc.state).thenReturn(
      MovieDetailLoaded(testMovieDetail),
    );
    when(mockMovieRecommendationBloc.state).thenReturn(
      MovieRecommendationLoaded(<Movie>[]),
    );
    when(mockWatchlistMovieBloc.state).thenReturn(
      WatchlistMovieStatusLoaded(status: true),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockWatchlistMovieBloc.stream).thenAnswer(
      (_) => Stream.fromIterable(
        [
          WatchlistMovieStatusLoaded(status: false),
          WatchlistMovieStatusLoaded(
              status: true, message: 'Added to Watchlist')
        ],
      ),
    );
    when(mockMovieRecommendationBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockMovieDetailBloc.state).thenReturn(
      MovieDetailLoaded(testMovieDetail),
    );
    when(mockMovieRecommendationBloc.state).thenReturn(
      MovieRecommendationLoaded(<Movie>[]),
    );
    when(mockWatchlistMovieBloc.state).thenReturn(
      WatchlistMovieStatusLoaded(status: false),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    await expectLater(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockWatchlistMovieBloc.stream).thenAnswer(
      (_) => Stream.fromIterable(
        [
          WatchlistMovieStatusLoaded(status: false),
          WatchlistMovieStatusLoaded(status: false, message: 'Failed')
        ],
      ),
    );
    when(mockMovieRecommendationBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockMovieDetailBloc.state).thenReturn(
      MovieDetailLoaded(testMovieDetail),
    );
    when(mockMovieRecommendationBloc.state).thenReturn(
      MovieRecommendationLoaded(<Movie>[]),
    );
    when(mockWatchlistMovieBloc.state).thenReturn(
      WatchlistMovieStatusLoaded(status: false),
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    await expectLater(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
