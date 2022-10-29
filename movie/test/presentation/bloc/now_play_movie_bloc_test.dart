import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'now_play_movie_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayMovieBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = NowPlayMovieBloc(mockGetNowPlayingMovies);
  });

  test('initial should be Empty', () {
    expect(movieNowPlayingBloc.state, NowPlayMovieEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<NowPlayMovieBloc, NowPlayMovieState>(
      'Should emit [NowPlayMovieLoading, NowPlayMovieHasData] when get now playing movie data is successful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayMovie()),
      expect: () => [
        NowPlayMovieLoading(),
        NowPlayMovieHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayMovieBloc, NowPlayMovieState>(
      'Should emit [NowPlayMovieLoading, NowPlayMovieError] when get now playing movie data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchNowPlayMovie()),
      expect: () => [
        NowPlayMovieLoading(),
        const NowPlayMovieError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
