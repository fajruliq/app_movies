import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/now_play_movie_page.dart';

import '../../../../core/test/dummy_objects.dart';

class MockNowPlayMovieBloc
    extends MockBloc<NowPlayMovieEvent, NowPlayMovieState>
    implements NowPlayMovieBloc {}

class NowPlayMovieEventFake extends Fake implements NowPlayMovieEvent {}

class NowPlayMovieStateFake extends Fake implements NowPlayMovieState {}


void main() {
  late MockNowPlayMovieBloc mockNowPlayMovieBloc;

  setUpAll(() {
    registerFallbackValue(NowPlayMovieEventFake());
    registerFallbackValue(NowPlayMovieStateFake());
  });

  setUp(() {
    mockNowPlayMovieBloc = MockNowPlayMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayMovieBloc>.value(
      value: mockNowPlayMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
          (WidgetTester tester) async {
        when(() => mockNowPlayMovieBloc.state).thenReturn(NowPlayMovieLoading());

        final progressBarFinder = find.byType(CircularProgressIndicator);
        final centerFinder = find.byType(Center);

        await tester.pumpWidget(_makeTestableWidget(NowPlayMoviePage()));

        expect(centerFinder, findsOneWidget);
        expect(progressBarFinder, findsOneWidget);
      });

  testWidgets('Page should display ListView when data is loaded',
          (WidgetTester tester) async {

        when(() => mockNowPlayMovieBloc.state)
            .thenReturn(NowPlayMovieHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(_makeTestableWidget(NowPlayMoviePage()));

        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display text with message when Error',
          (WidgetTester tester) async {
        when(() => mockNowPlayMovieBloc.state)
            .thenReturn(const NowPlayMovieError('Error Message'));

        final textFinder = find.byKey(const Key('error_message'));

        await tester.pumpWidget(_makeTestableWidget(NowPlayMoviePage()));

        expect(textFinder, findsOneWidget);
      });
}
