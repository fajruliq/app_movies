import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_page.dart';

class MockWatchlistTvBloc
    extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class WatchlistTvEventFake extends Fake
    implements WatchlistTvEvent {}

class WatchlistTvStateFake extends Fake
    implements WatchlistTvState {}


void main() {
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUp(() {
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  setUpAll(() {
    registerFallbackValue(WatchlistTvEventFake());
    registerFallbackValue(WatchlistTvStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvBloc.state)
        .thenReturn(WatchlistTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvBloc.state)
        .thenReturn(const WatchlistTvHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(listViewFinder, findsOneWidget);
  });
  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvBloc.state)
        .thenReturn(const WatchlistTvError('error_message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
