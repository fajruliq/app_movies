import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTv;

  TvSearchBloc(this._searchTv) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final searchResult = await _searchTv.execute(query);

      searchResult.fold((failure) => emit(SearchError(failure.message)),
          (data) => emit(SearchHasData(data)));
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
