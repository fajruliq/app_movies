import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tv_bloc/on_the_air_tv_bloc.dart';

import '../widgets/tv_card_list.dart';



class OnTheAirTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/playing-tv';

  @override
  _OnTheAirTvState createState() => _OnTheAirTvState();
}

class _OnTheAirTvState extends State<OnTheAirTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        BlocProvider.of<OnTheAirTvBloc>(context, listen: false)
            .add(FetchOnTheAirTv()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On The Air TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
          builder: (context, state) {
            if (state is OnTheAirTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is OnTheAirTvError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Text('Failed');
            }
          },
        ),
      ),
    );
  }
}