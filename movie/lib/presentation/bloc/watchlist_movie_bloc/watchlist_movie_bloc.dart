import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies _getWatchlistMovie;
  final GetWatchListStatus _getWatchListMovieStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;

  WatchlistMovieBloc(this._getWatchlistMovie, this._getWatchListMovieStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistMovieEmpty()) {
    on<FetchWatchlistMovie>(
      (event, emit) async {
        emit(WatchlistMovieLoading());
        final watchlistResult = await _getWatchlistMovie.execute();

        watchlistResult.fold(
            (failure) => emit(WatchlistMovieError(failure.message)),
            (data) => emit(WatchlistMovieHasData(data)));
      },
    );

    on<LoadWatchlistStatus>(((event, emit) async {
      final id = event.id;
      final result = await _getWatchListMovieStatus.execute(id);

      emit(WatchlistHasData(result));
    }));

    on<AddWatchlistMovie>((event, emit) async {
      final movie = event.movie;

      final result = await _saveWatchlist.execute(movie);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')),
      );

      add(LoadWatchlistStatus(movie.id));
    });

    on<DeleteWatchlistMovie>((event, emit) async {
      final movie = event.movie;

      final result = await _removeWatchlist.execute(movie);
      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) =>
            emit(const WatchlistSuccess('Removed from Watchlist')),
      );
      add(LoadWatchlistStatus(movie.id));
    });
  }
}
