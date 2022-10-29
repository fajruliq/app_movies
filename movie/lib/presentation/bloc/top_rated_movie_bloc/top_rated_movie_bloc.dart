import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovie;

  TopRatedMovieBloc(this._getTopRatedMovie) : super(TopRatedMovieEmpty()) {
    on<FetchTopRatedMovie>(
      (event, emit) async {
        emit(TopRatedMovieLoading());

        final topRatedResult = await _getTopRatedMovie.execute();

        topRatedResult.fold(
          (failure) => emit(TopRatedMovieError(failure.message)),
          (data) => emit(TopRatedMovieHasData(data)));
        },
    );
  }
}