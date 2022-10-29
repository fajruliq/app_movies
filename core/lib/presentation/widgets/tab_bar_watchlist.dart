import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/watchlist_movies_page.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';
import 'package:tv_series/presentation/pages/watchlist_tv_page.dart';

import '../../common/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TabBarWatchlist extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _TabBarWatchlistState createState() => _TabBarWatchlistState();
}

class _TabBarWatchlistState extends State<TabBarWatchlist> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
            .add(FetchWatchlistMovie()));
    Future.microtask(() =>
        BlocProvider.of<WatchlistTvBloc>(context, listen: false)
            .add(FetchWatchlistTv()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }
  @override
  void didPopNext() {
    BlocProvider.of<WatchlistMovieBloc>(context, listen: false)
        .add(FetchWatchlistMovie());
    BlocProvider.of<WatchlistTvBloc>(context, listen: false)
        .add(FetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist Tonton'),
          bottom: TabBar(
            indicatorColor: Colors.amber,
            tabs: [
              Tab(
                text: 'Movies',
                icon: Icon(Icons.movie_creation_outlined),
              ),
              Tab(
                text: 'TV Series',
                icon: Icon(Icons.tv_outlined),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WatchlistMoviesPage(),
            WatchlistTvPage(),
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

