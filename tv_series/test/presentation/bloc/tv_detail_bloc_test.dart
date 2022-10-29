import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';


@GenerateMocks([GetTvDetail])
void main() {
  late TvDetailBloc tvSeriesDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvSeriesDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvSeriesDetailBloc.state, TvDetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [TvDetailLoading, TvDetailHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [TvDetailLoading, TvDetailError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSeriesDetailBloc;
    },
    act: (bloc) => bloc.add(const FetchTvDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      const TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    },
  );
}
