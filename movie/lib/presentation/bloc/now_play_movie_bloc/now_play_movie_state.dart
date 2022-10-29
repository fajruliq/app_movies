part of 'now_play_movie_bloc.dart';

abstract class NowPlayMovieState extends Equatable {
  const NowPlayMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayMovieEmpty extends NowPlayMovieState {}

class NowPlayMovieLoading extends NowPlayMovieState {}

class NowPlayMovieError extends NowPlayMovieState {
  final String message;

  const NowPlayMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayMovieHasData extends NowPlayMovieState {
  final List<Movie> result;

  const NowPlayMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}
