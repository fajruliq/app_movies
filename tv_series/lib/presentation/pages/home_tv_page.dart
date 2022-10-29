import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/widgets/drawer_component.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/on_the_air_tv_bloc/on_the_air_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/search_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

import '../../domain/entities/tv.dart';
import 'on_the_air_tv_page.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tv';
  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<OnTheAirTvBloc>(context, listen: false)
        .add(FetchOnTheAirTv());
    BlocProvider.of<TopRatedTvBloc>(context, listen: false)
        .add(FetchTopRatedTv());
    BlocProvider.of<PopularTvBloc>(context, listen: false)
        .add(FetchPopularTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerComponent(),
      appBar: AppBar(
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTvPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title : 'On The Air Now',
                onTap: ()=> Navigator.pushNamed(context, OnTheAirTvPage.ROUTE_NAME)
              ),
              BlocBuilder<OnTheAirTvBloc, OnTheAirTvState>(
                  builder: (context, state) {
                if (state is OnTheAirTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OnTheAirTvHasData) {
                  return TvList(state.result);
                } else if (state is OnTheAirTvError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                  builder: (context, state) {
                if (state is PopularTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvHasData) {
                  return TvList(state.result);
                } else if (state is PopularTvError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                  builder: (context, state) {
                if (state is TopRatedTvLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvHasData) {
                  return TvList(state.result);
                } else if (state is TopRatedTvError) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvies;

  TvList(this.tvies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvies.length,
      ),
    );
  }
}
