import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';

import '../../../../core/test/dummy_objects.dart';

class MockPopularTvBloc
    extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class PopularTvEventFake extends Fake implements PopularTvEvent {}

class PopularTvStateFake extends Fake implements PopularTvState {}


void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvEventFake());
    registerFallbackValue(PopularTvStateFake());
  });

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(const PopularTvError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
