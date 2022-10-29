import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations _getRecommendationMovies;

  RecommendationMovieBloc(this._getRecommendationMovies)
      : super(RecommendationMovieEmpty()) {
    on<FetchRecommendationMovie>((event, emit) async {
      final id = event.id;

      emit(RecommendationMovieLoading());

      final recommendationResult = await _getRecommendationMovies.execute(id);

      recommendationResult.fold(
        (failure) => emit(RecommendationMovieError(failure.message)),
        (data) => emit(RecommendationMovieHasData(data)),
      );
    });
  }
}
