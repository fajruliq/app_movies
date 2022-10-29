import 'package:flutter_test/flutter_test.dart';
import 'movie_watchlist_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late WatchlistMovieBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchlistMovieStatus;
  late MockSaveWatchlist mockSaveWatchlistMovie;
  late MockRemoveWatchlist mockRemoveWatchlistMovie;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistMovieStatus = MockGetWatchListStatus();
    mockSaveWatchlistMovie = MockSaveWatchlist();
    mockRemoveWatchlistMovie = MockRemoveWatchlist();
    movieWatchlistBloc = WatchlistMovieBloc(
        mockGetWatchlistMovies,
        mockGetWatchlistMovieStatus,
        mockSaveWatchlistMovie,
        mockRemoveWatchlistMovie);
  });

  test('initial state should be empty', () {
    expect(movieWatchlistBloc.state, WatchlistMovieEmpty());
  });

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [WatchlistMovieLoading, WatchlistMovieHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistMovieLoading(),
      WatchlistMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<WatchlistMovieBloc, WatchlistMovieState>(
    'Should emit [WatchlistMovieLoading, WatchlistMovieError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistMovie()),
    expect: () => [
      WatchlistMovieLoading(),
      const WatchlistMovieError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
