import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';


@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc tvSeriesPopularBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvSeriesPopularBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('initial should be Empty', () {
    expect(tvSeriesPopularBloc.state, PopularTvEmpty());
  });

  group('Now Playing TVSeries', () {
    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [PopularTvLoading, PopularTvHasData] when get popular tv data is successful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        PopularTvLoading(),
        PopularTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [PopularTvLoading, PopularTvError] when get popular tv data is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        return tvSeriesPopularBloc;
      },
      act: (bloc) => bloc.add(FetchPopularTv()),
      expect: () => [
        PopularTvLoading(),
        const PopularTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}
