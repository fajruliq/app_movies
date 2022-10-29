import 'movie_recommendation_bloc_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late RecommendationMovieBloc movieRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendation;

  setUp(() {
    mockGetMovieRecommendation = MockGetMovieRecommendations();
    movieRecommendationBloc =
        RecommendationMovieBloc(mockGetMovieRecommendation);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(movieRecommendationBloc.state, RecommendationMovieEmpty());
  });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'Should emit [RecommendationMovieLoading, RecommendationMovieHasData]  when recommendation data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationMovie(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tId));
    },
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'Should emit [RecommendationMovieLoading, RecommendationMovieError] when recommendation data is gotten unsuccessfully',
    build: () {
      when(mockGetMovieRecommendation.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationMovie(tId)),
    expect: () => [
      RecommendationMovieLoading(),
      const RecommendationMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(tId));
    },
  );
}
