import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/drawer_component.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import '../../domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'now_play_movie_page.dart';


class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () {
          BlocProvider.of<NowPlayMovieBloc>(context, listen: false)
              .add(FetchNowPlayMovie());
          BlocProvider.of<TopRatedMovieBloc>(context, listen: false)
              .add(FetchTopRatedMovie());
          BlocProvider.of<PopularMovieBloc>(context, listen: false)
              .add(FetchPopularMovie());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchMoviesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
               title: "Now Playing",
                onTap: ()=> Navigator.pushNamed(context, NowPlayMoviePage.ROUTE_NAME)

              ),
              BlocBuilder<NowPlayMovieBloc, NowPlayMovieState>(
                  builder: (context, state) {
                if (state is NowPlayMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayMovieHasData) {
                  return MovieList(state.result);
                } else if (state is NowPlayMovieError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMovieBloc, PopularMovieState>(
                  builder: (context, state) {
                if (state is PopularMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularMovieHasData) {
                  return MovieList(state.result);
                } else if (state is PopularMovieError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                  builder: (context, state) {

                if (state is TopRatedMovieLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedMovieHasData) {
                  return MovieList(state.result);
                } else if (state is TopRatedMovieError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
