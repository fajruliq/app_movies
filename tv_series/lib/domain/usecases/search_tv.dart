import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';


import '../entities/tv.dart';
import '../repositories/tv_repository.dart';


class SearchTv {
  final TvRepository repository;

  SearchTv(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) async {
    return await repository.searchTv(query);
  }
}
