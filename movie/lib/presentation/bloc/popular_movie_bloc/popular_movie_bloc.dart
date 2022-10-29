import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopGetPopularMovie;

  PopularMovieBloc(this._getPopGetPopularMovie) : super(PopularMovieEmpty()) {
    on<FetchPopularMovie>(
      (event, emit) async {
        emit(PopularMovieLoading());

        final popularResult = await _getPopGetPopularMovie.execute();

        popularResult.fold(
          (failure) => emit(PopularMovieError(failure.message)),
          (data) => emit(PopularMovieHasData(data)));
      },
    );
  }
}
