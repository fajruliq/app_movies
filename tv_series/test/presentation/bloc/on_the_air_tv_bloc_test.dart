import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'on_the_air_tv_bloc_test.mocks.dart';



@GenerateMocks([GetOnTheAirTv])
void main() {
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late OnTheAirTvBloc tvSeriesOnAirBloc;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    tvSeriesOnAirBloc = OnTheAirTvBloc(mockGetOnTheAirTv);
  });

  test('initial should be Empty', () {
    expect(tvSeriesOnAirBloc.state, OnTheAirTvEmpty());
  });

  group('Now Playing TVSeries', () {
    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'Should emit [OnTheAirTvLoading, OnTheAirTvHasData] when get now playing tv data is successful',
      build: () {
        when(mockGetOnTheAirTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvSeriesOnAirBloc;
      },
      act: (bloc) => bloc.add(FetchOnTheAirTv()),
      expect: () => [
        OnTheAirTvLoading(),
        OnTheAirTvHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );

    blocTest<OnTheAirTvBloc, OnTheAirTvState>(
      'Should emit [OnTheAirTvLoading, OnTheAirTvError] when get now playing tv data is unsuccessful',
      build: () {
        when(mockGetOnTheAirTv.execute()).thenAnswer(
            (_) async => Left(ServerFailure('Server Failure')));
        return tvSeriesOnAirBloc;
      },
      act: (bloc) => bloc.add(FetchOnTheAirTv()),
      expect: () => [
        OnTheAirTvLoading(),
        const OnTheAirTvError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetOnTheAirTv.execute());
      },
    );
  });
}
