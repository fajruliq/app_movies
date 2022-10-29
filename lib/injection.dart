

import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie/movie.dart';
import 'package:tv_series/data/datasources/tv_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_remote_data_source.dart';
import 'package:tv_series/data/repositories/tv_repository_impl.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/domain/usecases/get_tv_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_recommendation.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_series/domain/usecases/search_tv.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tv_bloc/on_the_air_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_bloc/recommendation_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

final locator = GetIt.instance;

void init() {
// bloc
  locator.registerFactory(
        () => SearchMoviesBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => MovieDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => RecommendationMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMovieBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
        () => NowPlayMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularMovieBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedMovieBloc(
      locator(),
    ),
  );

  // tv_series
  locator.registerFactory(
        () => TvSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TvDetailBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => RecommendationTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistTvBloc(
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
        () => OnTheAirTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => PopularTvBloc(
      locator(),
    ),
  );
  locator.registerFactory(
        () => TopRatedTvBloc(
      locator(),
    ),
  );

  // use case - Movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // usecase - Tv
  locator.registerLazySingleton(() => GetPopularTv(locator()));
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTv(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecomendation(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTv(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
        () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
          () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
          () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
          () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
