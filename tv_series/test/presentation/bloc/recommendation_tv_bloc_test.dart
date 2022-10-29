import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:tv_series/tv_series.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../../../../core/test/dummy_objects.dart';
import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecomendation])
void main() {
  late RecommendationTvBloc tvSeriesRecommendationBloc;
  late MockGetTvRecomendation mockGetRecommendationTv;

  setUp(() {
    mockGetRecommendationTv = MockGetTvRecomendation();
    tvSeriesRecommendationBloc =
        RecommendationTvBloc(mockGetRecommendationTv);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvSeriesRecommendationBloc.state, RecommendationTvEmpty());
  });

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [RecommendationTvLoading, RecommendationTvHasData]  when recommendation data is gotten successfully',
    build: () {
      when(mockGetRecommendationTv.execute(tId))
          .thenAnswer((_) async => Right(testTvList));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTv(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      RecommendationTvLoading(),
      RecommendationTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTv.execute(tId));
    },
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>(
    'Should emit [RecommendationTvLoading, RecommendationTvError] when recommendation data is gotten unsuccessfully',
    build: () {
      when(mockGetRecommendationTv.execute(tId))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvSeriesRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchRecommendationTv(tId)),
    expect: () => [
      RecommendationTvLoading(),
      const RecommendationTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetRecommendationTv.execute(tId));
    },
  );
}
