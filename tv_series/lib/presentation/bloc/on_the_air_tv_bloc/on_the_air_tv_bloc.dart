import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:bloc/bloc.dart';

part 'on_the_air_tv_event.dart';
part 'on_the_air_tv_state.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTv _getOnTheAirTv;

  OnTheAirTvBloc(this._getOnTheAirTv) : super(OnTheAirTvEmpty()) {
    on<FetchOnTheAirTv>(
      (event, emit) async {
        emit(OnTheAirTvLoading());

        final onAirResult = await _getOnTheAirTv.execute();

        onAirResult.fold((failure) => emit(OnTheAirTvError(failure.message)),
            (data) => emit(OnTheAirTvHasData(data)));
      },
    );
  }
}
