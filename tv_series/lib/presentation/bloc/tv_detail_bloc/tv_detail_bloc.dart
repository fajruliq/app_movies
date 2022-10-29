import 'package:bloc/bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:equatable/equatable.dart';
part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc
    extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail _getTvDetail;

  TvDetailBloc(this._getTvDetail) : super(TvDetailEmpty()) {
    on<FetchTvDetail>(
      (event, emit) async {
        final id = event.id;

        emit(TvDetailLoading());
        final detailResult = await _getTvDetail.execute(id);

        detailResult.fold(
          (failure) => emit(TvDetailError(failure.message)),
          (data) => emit(TvDetailHasData(data)));
        },
    );
  }
}



