import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/data/repositories/tv_repository_impl.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';

import '../../../../core/test/helpers/test_helper.mocks.dart';
import '../../../../core/test/dummy_objects.dart';
void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(
      remoteDataSource: mockTvRemoteDataSource,
      localDataSource: mockTvLocalDataSource,
    );
  });

  final tTvModel = TvModel(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    firstAirDate: '2021-01-01',
    genreIds: [1, 2],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTv = Tv(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    firstAirDate: '2021-01-01',
    genreIds: [1, 2],
    id: 1,
    name: 'name',
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1.0,
    posterPath: '/posterPath',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('On The Air', () {
    test('hould return remote data when the call to remote data source is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.getOnTheAirTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getOnTheAirTv();
      // assert
      verify(mockTvRemoteDataSource.getOnTheAirTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });
    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getOnTheAirTv())
          .thenAnswer((_) => throw ServerFailure(''));
      // act
      final result = await repository.getOnTheAirTv();
      // assert
      verify(mockTvRemoteDataSource.getOnTheAirTv());
      expect(result, equals(Left(ServerFailure(''))));
    });
    test(
        'should return connection failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getOnTheAirTv())
              .thenAnswer((_) => throw ConnectionFailure(''));
          // act
          final result = await repository.getOnTheAirTv();
          // assert
          verify(mockTvRemoteDataSource.getOnTheAirTv());
          expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
    test(
        'should return tlsexception when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getOnTheAirTv())
              .thenAnswer((_) => throw TlsException(''));
          // act
          final result = await repository.getOnTheAirTv();
          // assert
          verify(mockTvRemoteDataSource.getOnTheAirTv());
          expect(result, equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n'))));
        });


  });

  group('Popular Tv', () {
    test('should return movie list when call to data source is success', () async {
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getPopularTv();

      verify(mockTvRemoteDataSource.getPopularTv());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTv()).thenThrow(ServerFailure(''));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });
    test(
        'should return connection failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getPopularTv())
              .thenAnswer((_) => throw ConnectionFailure(''));
          // act
          final result = await repository.getPopularTv();
          // assert
          verify(mockTvRemoteDataSource.getPopularTv());
          expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
    test(
        'should return tlsexception when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getPopularTv())
              .thenAnswer((_) => throw TlsException(''));
          // act
          final result = await repository.getPopularTv();
          // assert
          verify(mockTvRemoteDataSource.getPopularTv());
          expect(result, equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n'))));
        });
  });

  group('Top Rated Tv', () {
    test('should return movie list when call to data source is successful', () async {
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTopRatedTv();

      verify(mockTvRemoteDataSource.getTopRatedTv());

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) => throw ServerFailure(''));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result, equals(Left(ServerFailure(''))));
    });
    test(
        'should return connection failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTopRatedTv())
              .thenAnswer((_) => throw ConnectionFailure(''));
          // act
          final result = await repository.getTopRatedTv();
          // assert
          verify(mockTvRemoteDataSource.getTopRatedTv());
          expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
    test(
        'should return tlsexception when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTopRatedTv())
              .thenAnswer((_) => throw TlsException(''));
          // act
          final result = await repository.getTopRatedTv();
          // assert
          verify(mockTvRemoteDataSource.getTopRatedTv());
          expect(result, equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n'))));
        });

  });



  group('TvDetail Tv', () {
    int id= 1;
    test('should return movie list when call to data source is successful', () async {
      when(mockTvRemoteDataSource.getTvDetail(id))
          .thenAnswer((_) async => testTvDetailResponse);

      final result = await repository.getTvDetail(id);

      verify(mockTvRemoteDataSource.getTvDetail(id));
      final resultList = result.getOrElse(() => testTvDetail);
      expect(resultList, equals(testTvDetailResponse.toEntity()));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvDetail(id))
              .thenAnswer((_) => throw ServerFailure(''));
          // act
          final result = await repository.getTvDetail(id);
          // assert
          verify(mockTvRemoteDataSource.getTvDetail(id));
          expect(result, equals(Left(ServerFailure(''))));
        });
    test(
        'should return connection failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvDetail(id))
              .thenAnswer((_) => throw ConnectionFailure(''));
          // act
          final result = await repository.getTvDetail(id);
          // assert
          verify(mockTvRemoteDataSource.getTvDetail(id));
          expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
    test(
        'should return tlsexception when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvDetail(id))
              .thenAnswer((_) => throw TlsException(''));
          // act
          final result = await repository.getTvDetail(id);
          // assert
          verify(mockTvRemoteDataSource.getTvDetail(id));
          expect(result, equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n'))));
        });

  });
  
  


  group('Search Tv', () {
    String? query= "";
    test('should return movie list when call to data source is successful', () async {
      when(mockTvRemoteDataSource.searchTv(query))
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.searchTv(query);

      verify(mockTvRemoteDataSource.searchTv(query));

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.searchTv(query))
              .thenAnswer((_) => throw ServerFailure(''));
          // act
          final result = await repository.searchTv(query);
          // assert
          verify(mockTvRemoteDataSource.searchTv(query));
          expect(result, equals(Left(ServerFailure(''))));
        });
    test(
        'should return connection failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.searchTv(query))
              .thenAnswer((_) => throw ConnectionFailure(''));
          // act
          final result = await repository.searchTv(query);
          // assert
          verify(mockTvRemoteDataSource.searchTv(query));
          expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
    test(
        'should return tlsexception when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.searchTv(query))
              .thenAnswer((_) => throw TlsException(''));
          // act
          final result = await repository.searchTv(query);
          // assert
          verify(mockTvRemoteDataSource.searchTv(query));
          expect(result, equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n'))));
        });

  });



  group('Recomennded Tv', () {
    int id= 1;
    test('should return movie list when call to data source is successful', () async {
      when(mockTvRemoteDataSource.getTvRecommendations(id))
          .thenAnswer((_) async => tTvModelList);

      final result = await repository.getTvRecommended(id);

      verify(mockTvRemoteDataSource.getTvRecommendations(id));

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvRecommendations(id))
              .thenAnswer((_) => throw ServerFailure(''));
          // act
          final result = await repository.getTvRecommended(id);
          // assert
          verify(mockTvRemoteDataSource.getTvRecommendations(id));
          expect(result, equals(Left(ServerFailure(''))));
        });
    test(
        'should return connection failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvRecommendations(id))
              .thenAnswer((_) => throw ConnectionFailure(''));
          // act
          final result = await repository.getTvRecommended(id);
          // assert
          verify(mockTvRemoteDataSource.getTvRecommendations(id));
          expect(result, equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
    test(
        'should return tlsexception when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvRemoteDataSource.getTvRecommendations(id))
              .thenAnswer((_) => throw TlsException(''));
          // act
          final result = await repository.getTvRecommended(id);
          // assert
          verify(mockTvRemoteDataSource.getTvRecommendations(id));
          expect(result, equals(Left(SSLFailure('CERTIFICATE_VERIFY_FAILED\n'))));
        });

  });


  group('Watchlist Tv', () {
    test('should return movie list when call to data source is successful', () async {
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => testTvTableList);

      final result = await repository.getTvWatchList();

      verify(mockTvLocalDataSource.getWatchlistTv());

      final resultList = result.getOrElse(() => []);
      expect(resultList,testTvTableList.map((e) => e.toEntity()).toList());
    });

  });

  group('Add TO watchlist Tv', () {
    int id =1;
    test('should return movie list when call to data source is successful', () async {
      when(mockTvLocalDataSource.getTvById(id))
          .thenAnswer((_) async => testTvTable);

      final result = await repository.isAddedToWatchList(id);

      verify(mockTvLocalDataSource.getTvById(id));

      expect(result,equals(true));
    });

  });




  group('Remove Tv Wathclist', () {
    int id= 1;
    test('should return movie list when call to data source is successful', () async {
      when(mockTvLocalDataSource.removeTvWatchlist(TvTable.fromEntity(testTvDetail)))
          .thenAnswer((_) async => "");

      final result = await repository.removeTvWatchList(testTvDetail);

      verify(mockTvLocalDataSource.removeTvWatchlist(testTvTable));

      
      expect(result, equals(Right("")));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvLocalDataSource.removeTvWatchlist(TvTable.fromEntity(testTvDetail)))
              .thenAnswer((_) => throw DatabaseException(""));
          // act
          final result = await repository.removeTvWatchList(testTvDetail);
          // assert
          verify(mockTvLocalDataSource.removeTvWatchlist(testTvTable));
          expect(result, equals(Left(DatabaseFailure(""))));
        });

  });


  group('Save Tv Wathclist', () {
    int id= 1;
    test('should return movie list when call to data source is successful', () async {
      when(mockTvLocalDataSource.insertTvWatchlist(TvTable.fromEntity(testTvDetail)))
          .thenAnswer((_) async => "");

      final result = await repository.saveTvWatchList(testTvDetail);

      verify(mockTvLocalDataSource.insertTvWatchlist(testTvTable));


      expect(result, equals(Right("")));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockTvLocalDataSource.insertTvWatchlist(TvTable.fromEntity(testTvDetail)))
              .thenAnswer((_) => throw DatabaseException(""));
          // act
          final result = await repository.saveTvWatchList(testTvDetail);
          // assert
          verify(mockTvLocalDataSource.insertTvWatchlist(testTvTable));
          expect(result, equals(Left(DatabaseFailure(""))));
        });

  });



}
