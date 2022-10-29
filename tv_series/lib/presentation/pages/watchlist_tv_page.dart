import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

import '../widgets/tv_card_list.dart';

class WatchlistTvPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child:
      BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, tvWatchlist) {
        if (tvWatchlist  is WatchlistTvLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (tvWatchlist is WatchlistTvHasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final tv = tvWatchlist.result[index];
              return TvCard(tv);
            },
            itemCount: tvWatchlist.result.length,
          );
        }else if (tvWatchlist is WatchlistTvError) {
          return Center(
            key: const Key('error_message'),
            child: Text(tvWatchlist.message),
          );
        } else {
          return Container();
        }
      }),
    );
  }


}
