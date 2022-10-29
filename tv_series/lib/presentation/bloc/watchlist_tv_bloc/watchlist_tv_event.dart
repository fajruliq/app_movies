part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class FetchWatchlistTv extends WatchlistTvEvent {}

class AddWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const AddWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class DeleteWatchlistTv extends WatchlistTvEvent {
  final TvDetail tvDetail;

  const DeleteWatchlistTv(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchlistTvStatus extends WatchlistTvEvent {
  final int id;

  const LoadWatchlistTvStatus(this.id);

  @override
  List<Object> get props => [id];
}
