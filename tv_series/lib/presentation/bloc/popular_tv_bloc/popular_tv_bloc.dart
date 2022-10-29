import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc/bloc.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc
    extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv)
      : super(PopularTvEmpty()) {
    on<FetchPopularTv>(
      (event, emit) async {
        emit(PopularTvLoading());

        final popularResult = await _getPopularTv.execute();

        popularResult.fold(
            (failure) => emit(PopularTvError(failure.message)),
            (data) => emit(PopularTvHasData(data)));
      },
    );
  }
}
