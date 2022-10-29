import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchListTv,
  GetWatchListTvStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist
])
void main() {
  late WatchlistTvBloc tvSeriesWatchlistBloc;
  late MockGetWatchListTv mockGetWatchListTv;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockSaveTvWatchlist mockSaveWatchlistTv;
  late MockRemoveTvWatchlist mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchListTv = MockGetWatchListTv();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveWatchlistTv = MockSaveTvWatchlist();
    mockRemoveWatchlistTv = MockRemoveTvWatchlist();
    tvSeriesWatchlistBloc = WatchlistTvBloc(
        mockGetWatchListTv,
        mockGetWatchListTvStatus,
        mockSaveWatchlistTv,
        mockRemoveWatchlistTv);
  });

  test('initial state should be empty', () {
    expect(tvSeriesWatchlistBloc.state, WatchlistTvEmpty());
  });

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [WatchlistTvLoading, WatchlistTvHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetWatchListTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistTvLoading(),
      WatchlistTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTv.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [WatchlistTvLoading, WatchlistTvError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchListTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlistTv()),
    expect: () => [
      WatchlistTvLoading(),
      const WatchlistTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTv.execute());
    },
  );
}
