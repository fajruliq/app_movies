import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendation.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecomendation usecase;
  late MockTvRepository mockTvRepository;
  //Init
  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecomendation(mockTvRepository);
  });

  final tId = 1;
  final tTv = <Tv>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTvRepository.getTvRecommended(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(tTv));
  });
}
