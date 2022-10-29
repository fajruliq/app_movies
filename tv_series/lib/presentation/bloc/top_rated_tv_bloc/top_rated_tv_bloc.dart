import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc/bloc.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc
    extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTv;

  TopRatedTvBloc(this._getTopRatedTv)
      : super(TopRatedTvEmpty()) {
    on<FetchTopRatedTv>(
      (event, emit) async {
        emit(TopRatedTvLoading());

        final topRatedResult = await _getTopRatedTv.execute();

        topRatedResult.fold(
            (failure) => emit(TopRatedTvError(failure.message)),
            (data) => emit(TopRatedTvHasData(data)));
      },
    );
  }
}
