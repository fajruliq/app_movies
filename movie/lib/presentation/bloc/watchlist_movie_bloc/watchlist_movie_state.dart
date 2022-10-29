part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  const WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> result;

  const WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistFailure extends WatchlistMovieState {
  final String message;

  const WatchlistFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSuccess extends WatchlistMovieState {
  final String message;

  const WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends WatchlistMovieState {
  final bool isAdded;

  const WatchlistHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}
