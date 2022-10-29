import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc tvSeriesTopRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvSeriesTopRatedBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial should be Empty', () {
    expect(tvSeriesTopRatedBloc.state, TopRatedTvEmpty());
  });

  group('Now Playing TVSeries', () {
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [TopRatedTvLoading, TopRatedTvHasData] when get top rated tv data is successful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [TopRatedTvLoading, TopRatedTvError] when get top rated tv data is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
            (_) async =>  Left(ServerFailure('Server Failure')));
        return tvSeriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        const TopRatedTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}
