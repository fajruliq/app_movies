import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/movie.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_card_list.dart';



class NowPlayMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/playing-movie';

  @override
  _NowPlayMoviePageState createState() => _NowPlayMoviePageState();
}

class _NowPlayMoviePageState extends State<NowPlayMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<NowPlayMovieBloc>(context, listen: false)
            .add(FetchNowPlayMovie()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowPlayMovieBloc, NowPlayMovieState>(
          builder: (context, state) {
            if (state is NowPlayMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayMovieHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is NowPlayMovieError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}