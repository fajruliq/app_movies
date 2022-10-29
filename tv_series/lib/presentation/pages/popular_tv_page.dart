import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';

import '../widgets/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<PopularTvBloc>(context, listen: false)
            .add(FetchPopularTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            if (state is PopularTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvData = state.result[index];
                  return TvCard(tvData);
                },
                itemCount: state.result.length,
              );
            } else if (state is PopularTvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
    );
  }
}
