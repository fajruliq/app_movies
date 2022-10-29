
import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/domain/entities/tv.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: 'backdropPath',
    firstAirDate: '2022-09-15 12:03:20.591918',
    genreIds: [1, 2, 3],
    id: 2222,
    name: 'name',
    originCountry: ['country'],
    originalLanguage: 'id',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2000,
    posterPath: 'posterPath',
    voteAverage: 2000,
    voteCount: 22,
  );

  final tTv = Tv(
    backdropPath: 'backdropPath',
    firstAirDate: '2022-09-15 12:03:20.591918',
    genreIds: [1, 2, 3],
    id: 2222,
    name: 'name',
    originCountry: ['country'],
    originalLanguage: 'id',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2000,
    posterPath: 'posterPath',
    voteAverage: 2000,
    voteCount: 22,
  );

  test('should be subclass of tv entitry ', () async {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}
