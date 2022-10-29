

import 'package:about/about_page.dart';
import 'package:core/common/utils.dart';
import 'package:core/presentation/widgets/tab_bar_watchlist.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/now_play_movie_page.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/presentation/bloc/on_the_air_tv_bloc/on_the_air_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_bloc/recommendation_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/pages/home_tv_page.dart';
import 'package:tv_series/presentation/pages/on_the_air_tv_page.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/search_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HttpSSLPinning.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationMovieBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<RecommendationTvBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case NowPlayMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayMoviePage());
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchMoviesPage());
            case TabBarWatchlist.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TabBarWatchlist());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case OnTheAirTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => OnTheAirTvPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SearchTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchTvPage());
            case TopRatedTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (context) => TopRatedTvPage());
            case PopularTvPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (context) => PopularTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
