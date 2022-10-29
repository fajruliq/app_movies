import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'now_play_movie_event.dart';
part 'now_play_movie_state.dart';

class NowPlayMovieBloc
    extends Bloc<NowPlayMovieEvent, NowPlayMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayMovieEmpty()) {
    on<FetchNowPlayMovie>(
      (event, emit) async {
        emit(NowPlayMovieLoading());

        final nowPlayingResult = await _getNowPlayingMovies.execute();

        nowPlayingResult.fold(
            (failure) => emit(NowPlayMovieError(failure.message)),
            (data) => emit(NowPlayMovieHasData(data)));
      },
    );
  }
}
