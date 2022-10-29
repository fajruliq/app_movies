import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import '../../../../core/test/dummy_objects.dart';

class MockTvDetailBloc
    extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class MockRecommendationTvBloc
    extends MockBloc<RecommendationTvEvent, RecommendationTvState>
    implements RecommendationTvBloc {}

class RecommendationTvEventFake extends Fake
    implements RecommendationTvEvent {}

class RecommendationTvStateFake extends Fake
    implements RecommendationTvState {}

class MockWatchlistTvBloc
    extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class WatchlistTvEventFake extends Fake
    implements WatchlistTvEvent {}

class WatchlistTvStateFake extends Fake
    implements WatchlistTvState {}


void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockRecommendationTvBloc mockRecommendationTvBloc;
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(RecommendationTvEventFake());
    registerFallbackValue(RecommendationTvStateFake());
    registerFallbackValue(WatchlistTvEventFake());
    registerFallbackValue(WatchlistTvStateFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockRecommendationTvBloc = MockRecommendationTvBloc();
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
            create: (context) => mockTvDetailBloc),
        BlocProvider<RecommendationTvBloc>(
            create: (context) => mockRecommendationTvBloc),
        BlocProvider<WatchlistTvBloc>(
            create: (context) => mockWatchlistTvBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
          (WidgetTester tester) async {
        when(() => mockTvDetailBloc.state)
            .thenReturn(TvDetailHasData(testTvDetail));
        when(() => mockRecommendationTvBloc.state)
            .thenReturn(RecommendationTvHasData(testTvList));
        when(() => mockWatchlistTvBloc.state)
            .thenReturn(const WatchlistHasData(false));

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester
            .pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display check icon when tv is added to watchlist',
          (WidgetTester tester) async {
        when(() => mockTvDetailBloc.state)
            .thenReturn(TvDetailHasData(testTvDetail));
        when(() => mockRecommendationTvBloc.state)
            .thenReturn(RecommendationTvHasData(testTvList));
        when(() => mockWatchlistTvBloc.state)
            .thenReturn(const WatchlistHasData(true));

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester
            .pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });
}
