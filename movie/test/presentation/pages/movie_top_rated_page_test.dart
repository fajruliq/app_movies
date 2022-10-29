import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';

import '../../../../core/test/dummy_objects.dart';

class MockTopRatedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

class TopRatedMovieEventFake extends Fake implements TopRatedMovieEvent {}

class TopRatedMovieStateFake extends Fake implements TopRatedMovieState {}


void main() {
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMovieEventFake());
    registerFallbackValue(TopRatedMovieStateFake());
  });

  setUp(() {
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>.value(
      value: mockTopRatedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockTopRatedMovieBloc.state).thenReturn(TopRatedMovieLoading());

        final progressFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(centerFinder, findsOneWidget);
        expect(progressFinder, findsOneWidget);
      });

  testWidgets('Page should display when data is loaded',
          (WidgetTester tester) async {
        when(() => mockTopRatedMovieBloc.state)
            .thenReturn(TopRatedMovieHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockTopRatedMovieBloc.state)
            .thenReturn(const TopRatedMovieError('Error Message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

        expect(textFinder, findsOneWidget);
      });
}
