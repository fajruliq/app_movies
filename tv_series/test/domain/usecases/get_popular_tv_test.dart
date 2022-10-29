import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTv(mockTvRepository);
  });
  final tTv = <Tv>[];
  test('should get list of tv from the repository when execute function is called', () async {
    when(mockTvRepository.getPopularTv()).thenAnswer((_) async => Right(tTv));

    final result = await usecase.execute();
    expect(result, Right(tTv));
  });
}
