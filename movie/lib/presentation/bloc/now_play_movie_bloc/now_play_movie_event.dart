part of 'now_play_movie_bloc.dart';

abstract class NowPlayMovieEvent extends Equatable {
  const NowPlayMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchNowPlayMovie extends NowPlayMovieEvent {}
