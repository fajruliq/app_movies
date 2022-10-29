

import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_bloc/recommendation_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;

  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvDetailBloc>(context, listen: false)
          .add(FetchTvDetail(widget.id));
      BlocProvider.of<WatchlistTvBloc>(context, listen: false)
          .add(LoadWatchlistTvStatus(widget.id));
      BlocProvider.of<RecommendationTvBloc>(context, listen: false)
          .add(FetchRecommendationTv(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailHasData) {
            final tv = state.result;
            return SafeArea(
              child: DetailContent(
                  tv),
            );
          } else if (state is TvDetailError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tvDetail;


  DetailContent(this.tvDetail);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvDetail.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistTvBloc,
                                WatchlistTvState>(
                              listener: (context, state) {
                                if (state is WatchlistSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(state.message)));
                                } else if (state is WatchlistFailure) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    },
                                  );
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () async {
                                    if (state is WatchlistHasData) {
                                      if (state.isAdded == false) {
                                        context
                                            .read<WatchlistTvBloc>()
                                            .add(AddWatchlistTv(tvDetail));
                                      } else if (state.isAdded == true) {
                                        context
                                            .read<WatchlistTvBloc>()
                                            .add(DeleteWatchlistTv(
                                            tvDetail));
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (state is WatchlistHasData)
                                        if (state.isAdded == false)
                                          const Icon(Icons.add)
                                        else if (state.isAdded == true)
                                          const Icon(Icons.check),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tvDetail.genres),
                            ),
                            Text(
                              _showDuration(tvDetail.episodeRunTime),
                            ),
                            // _showDuration(tvDetail.episodeRunTime[0])
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: tvDetail.voteAverage / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                ),
                                itemSize: 24,
                              ),
                              Text('${tvDetail.voteAverage}')
                            ],
                          ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvDetail.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommended',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvBloc,
                                RecommendationTvState>(
                          builder: (context, state) {
                            if (state is RecommendationTvLoading) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is RecommendationTvError) {
                              return Text(state.message);
                            } else if (state is RecommendationTvHasData) {
                              final recommendedTv=
                                  state.result;
                              return Container(
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            TvDetailPage.ROUTE_NAME,
                                            arguments: recommendedTv[index].id,
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: Stack(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                'https://image.tmdb.org/t/p/w500${recommendedTv[index].posterPath}',
                                                placeholder: (context, url) => Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                                errorWidget: (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: recommendedTv.length,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }


  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(List<int> episodeRunTime) {
    if(episodeRunTime.isEmpty){
      return "Unknown";
    }
    int runtime = episodeRunTime[0];
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
