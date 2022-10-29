import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc
    extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchListTv _getWatchListTv;
  final GetWatchListTvStatus _getWatchListTvStatus;
  final SaveTvWatchlist _saveTvWatchList;
  final RemoveTvWatchlist _removeTvWatchList;

  WatchlistTvBloc(
      this._getWatchListTv,
      this._getWatchListTvStatus,
      this._saveTvWatchList,
      this._removeTvWatchList)
      : super(WatchlistTvEmpty()) {
    on<FetchWatchlistTv>(
      (event, emit) async {
        emit(WatchlistTvLoading());
        final watchlistResult = await _getWatchListTv.execute();

        watchlistResult.fold(
          (failure) => emit(WatchlistTvError(failure.message)),
          (data) => emit(WatchlistTvHasData(data)));
        },
    );
    on<LoadWatchlistTvStatus>(((event, emit) async {
      final id = event.id;
      final result = await _getWatchListTvStatus.execute(id);

      emit(WatchlistHasData(result));
    }));
    on<AddWatchlistTv>((event, emit) async {
      final tvSeries = event.tvDetail;

      final result = await _saveTvWatchList.execute(tvSeries);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')));
      add(LoadWatchlistTvStatus(tvSeries.id));
    });

    on<DeleteWatchlistTv>((event, emit) async {
      final tvSeries = event.tvDetail;

      final result = await _removeTvWatchList.execute(tvSeries);
      result.fold((failure) => emit(WatchlistFailure(failure.message)),
       (successMessage) => emit(const WatchlistSuccess('Removed from Watchlist')));
      add(LoadWatchlistTvStatus(tvSeries.id));
    });
  }
}
