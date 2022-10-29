import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('initial should be Empty', () {
    expect(moviePopularBloc.state, PopularMovieEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [PopularMovieLoading, PopularMovieHasData] when get popular movie data is successful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        PopularMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<PopularMovieBloc, PopularMovieState>(
      'Should emit [PopularMovieLoading, PopularMovieError] when get popular movie data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularMovie()),
      expect: () => [
        PopularMovieLoading(),
        const PopularMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
