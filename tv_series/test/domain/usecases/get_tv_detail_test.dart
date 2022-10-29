import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';

import '../../../../core/test/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));

    final result = await usecase.execute(tId);
    expect(result, Right(testTvDetail));
  });
}
