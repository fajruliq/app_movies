import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/remove_tv_watchlist.dart';

import '../../../../core/test/dummy_objects.dart';
import '../../../../core/test/helpers/test_helper.mocks.dart';


void main() {
  late RemoveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveTvWatchlist(mockTvRepository);
  });

  test('should remove watchlist movie from repository', () async {
    // arrange
    when(mockTvRepository.removeTvWatchList(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removeTvWatchList(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
