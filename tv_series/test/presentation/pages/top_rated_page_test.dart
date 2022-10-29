import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import '../../../../core/test/dummy_objects.dart';

class MockTopRatedTvBloc
    extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

class TopRatedTvEventFake extends Fake implements TopRatedTvEvent {}

class TopRatedTvStateFake extends Fake implements TopRatedTvState {}


void main() {
  late MockTopRatedTvBloc mockTopRatedTvBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTvEventFake());
    registerFallbackValue(TopRatedTvStateFake());
  });

  setUp(() {
    mockTopRatedTvBloc = MockTopRatedTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockTopRatedTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(TopRatedTvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(TopRatedTvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvBloc.state)
        .thenReturn(const TopRatedTvError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
