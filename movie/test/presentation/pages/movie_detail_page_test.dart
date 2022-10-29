import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

import '../../../../core/test/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockRecommendationMovieBloc
    extends MockBloc<RecommendationMovieEvent, RecommendationMovieState>
    implements RecommendationMovieBloc{}

class RecommendationMovieEventFake extends Fake
    implements RecommendationMovieEvent {}

class RecommendationMovieStateFake extends Fake
    implements RecommendationMovieState {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

class WatchlistMovieEventFake extends Fake implements WatchlistMovieEvent {}

class WatchlistMovieStateFake extends Fake implements WatchlistMovieState {}


void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockRecommendationMovieBloc mockRecommendationMovieBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(RecommendationMovieEventFake());
    registerFallbackValue(RecommendationMovieStateFake());
    registerFallbackValue(WatchlistMovieEventFake());
    registerFallbackValue(WatchlistMovieStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockRecommendationMovieBloc = MockRecommendationMovieBloc();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (context) => mockMovieDetailBloc),
        BlocProvider<RecommendationMovieBloc>(
            create: (context) => mockRecommendationMovieBloc),
        BlocProvider<WatchlistMovieBloc>(
            create: (context) => mockWatchlistMovieBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state)
            .thenReturn(MovieDetailHasData(testMovieDetail));
        when(() => mockRecommendationMovieBloc.state)
            .thenReturn(RecommendationMovieHasData(testMovieList));
        when(() => mockWatchlistMovieBloc.state)
            .thenReturn(const WatchlistHasData(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(
            _makeTestableWidget(MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
          (WidgetTester tester) async {
        when(() => mockMovieDetailBloc.state)
            .thenReturn(MovieDetailHasData(testMovieDetail));
        when(() => mockRecommendationMovieBloc.state)
            .thenReturn(RecommendationMovieHasData(testMovieList));
        when(() => mockWatchlistMovieBloc.state)
            .thenReturn(const WatchlistHasData(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(
            _makeTestableWidget( MovieDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });
}