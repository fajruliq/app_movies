
import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/season.dart';
import 'package:movie/data/models/movie_table.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:tv_series/data/models/created_by_model.dart';
import 'package:tv_series/data/models/te_episode_to_air_model.dart';
import 'package:tv_series/data/models/tv_detail_model.dart';
import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/domain/entities/created_by.dart';
import 'package:tv_series/domain/entities/production_country.dart';
import 'package:tv_series/domain/entities/spoken_language.dart';
import 'package:tv_series/domain/entities/te_episode_to_air.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';



final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);
final testTv = Tv(
  backdropPath: '',
  firstAirDate: '2021-01-01',
  id: 1,
  name: 'name',
  originCountry: ['en'],
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
  genreIds: [1],
);
final testTvTableList = [testTvTable];
final testMovieList = [testMovie];
final testTvList = [testTv];
final testTvDetailResponse = TvDetailResponse(
    adult: false,
    backdropPath: '',

    episodeRunTime: [1, 2, 3],
    firstAirDate: DateTime.parse('2021-01-01'),
    homepage: 'homepae',
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: DateTime.parse('2022-11-22'),

    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',

    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1, createdBy: [CreatedByModel(id: 1, creditId: "", name: "", gender: 1, profilePath: "")],
  genres: [GenreModel(id: 1, name: 'name')],
  lastEpisodeToAir: TEpisodeToAirModel(
      airDate: DateTime.parse('2022-11-22'),
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
      runtime: 20,
      showId: 1),
  nextEpisodeToAir: TEpisodeToAirModel(
      airDate: DateTime.parse('2022-11-22'),
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      productionCode: 'productionCode',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1,
      voteCount: 1,
      runtime: 20,
      showId: 1),
  productionCountries: [],
  seasons: [],
  spokenLanguages: [],
);



final testTvDetail = TvDetail(
    adult: false,
    backdropPath: '',
    createdBy: [
      CreatedBy(
          id: 1,
          creditId: '1',
          name: 'name',
          gender: 2,
          profilePath: 'profilePath')
    ],
    episodeRunTime: [1, 2, 3],
    firstAirDate: DateTime.parse('2021-01-01'),
    genres: [Genre(id: 1, name: 'name')],
    homepage: 'homepae',
    id: 1,
    inProduction: true,
    languages: ['en'],
    lastAirDate: DateTime.parse('2022-11-22'),
    lastEpisodeToAir: TEpisodeToAir(
        airDate: DateTime.parse('2022-11-22'),
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1,
        runtime: 20,
        showId: 1),
    name: 'name',
    nextEpisodeToAir: TEpisodeToAir(
        airDate: DateTime.parse('2022-11-22'),
        episodeNumber: 1,
        id: 1,
        name: 'name',
        overview: 'overview',
        productionCode: 'productionCode',
        seasonNumber: 1,
        stillPath: 'stillPath',
        voteAverage: 1,
        voteCount: 1,
        runtime: 20,
        showId: 1),
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    originCountry: ['en'],
    originalLanguage: 'en',
    originalName: 'name',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    seasons: [
      Season(
          airDate: DateTime.parse('2022-11-22'),
          episodeCount: 1,
          id: 1,
          name: 'name',
          overview: 'overview',
          posterPath: 'posterPath',
          seasonNumber: 1)
    ],
    spokenLanguages: [
      SpokenLanguage(
          englishName: 'englishName', iso6391: 'iso6391', name: 'name')
    ],
    status: 'status',
    tagline: 'tagline',
    type: 'type',
    voteAverage: 1,
    voteCount: 1,
    productionCountries: [
      ProductionCountry(iso31661: 'iso31661', name: 'name')
    ]);

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);
final testWatchlistTv = Tv.watchList(
  id: 1,
  posterPath: 'posterPath',
  overview: 'overview',
  name: 'name',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
