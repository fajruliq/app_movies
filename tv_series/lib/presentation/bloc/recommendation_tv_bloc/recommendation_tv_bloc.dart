import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc/bloc.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecomendation _getTvRecomendation;

  RecommendationTvBloc(this._getTvRecomendation)
      : super(RecommendationTvEmpty()) {
    on<FetchRecommendationTv>((event, emit) async {
      final id = event.id;

      emit(RecommendationTvLoading());

      final recommendationResult =
          await _getTvRecomendation.execute(id);

      recommendationResult.fold(
          (failure) => emit(RecommendationTvError(failure.message)),
          (data) => emit(RecommendationTvHasData(data)));
    });
  }
}
