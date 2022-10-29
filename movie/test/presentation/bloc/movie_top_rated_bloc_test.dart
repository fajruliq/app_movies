import 'package:flutter_test/flutter_test.dart';
import 'movie_top_rated_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test('initial should be Empty', () {
    expect(movieTopRatedBloc.state, TopRatedMovieEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should emit [TopRatedMovieLoading, TopRatedMovieHasData] when get top rated movie data is successful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      expect: () => [
        TopRatedMovieLoading(),
        TopRatedMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<TopRatedMovieBloc, TopRatedMovieState>(
      'Should emit [TopRatedMovieLoading, TopRatedMovieError] when get top rated movie data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedMovie()),
      expect: () => [
        TopRatedMovieLoading(),
        const TopRatedMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
