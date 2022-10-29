import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

import '../widgets/movie_card_list.dart';


class WatchlistMoviesPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
        builder: (context, movie) {
          if (movie is WatchlistMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (movie is WatchlistMovieHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final movieData = movie.result[index];
                return MovieCard(movieData);
              },
              itemCount: movie.result.length,
            );
          } else if (movie is WatchlistMovieError) {
            return Center(
              key: const Key('error_message'),
              child: Text(movie.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }


}
