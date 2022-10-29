import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';

import '../../../../core/test/dummy_objects.dart';

class MockOnTheAirTvBloc
    extends MockBloc<OnTheAirTvEvent, OnTheAirTvState>
    implements OnTheAirTvBloc {}

class OnTheAirTvEventFake extends Fake implements OnTheAirTvEvent {}

class OnTheAirTvStateFake extends Fake implements OnTheAirTvState {}


void main() {
  late MockOnTheAirTvBloc mockOnTheAirTvBloc;

  setUpAll(() {
    registerFallbackValue(OnTheAirTvEventFake());
    registerFallbackValue(OnTheAirTvStateFake());
  });

  setUp(() {
    mockOnTheAirTvBloc = MockOnTheAirTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvBloc>.value(
      value: mockOnTheAirTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockOnTheAirTvBloc.state)
        .thenReturn(OnTheAirTvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockOnTheAirTvBloc.state)
        .thenReturn(OnTheAirTvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockOnTheAirTvBloc.state)
        .thenReturn(const OnTheAirTvError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
