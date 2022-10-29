part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistMovie extends WatchlistMovieEvent {}

class AddWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  const AddWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class DeleteWatchlistMovie extends WatchlistMovieEvent {
  final MovieDetail movie;

  const DeleteWatchlistMovie(this.movie);

  @override
  List<Object> get props => [movie];
}

class LoadWatchlistStatus extends WatchlistMovieEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
