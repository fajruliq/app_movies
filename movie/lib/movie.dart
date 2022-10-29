library movie;


// data -> datasources
export 'data/datasources/movie_local_data_source.dart';
export 'data/datasources/movie_remote_data_source.dart';

// data -> models
export 'data/models/movie_detail_model.dart';
export 'data/models/movie_model.dart';
export 'data/models/movie_response.dart';
export 'data/models/movie_table.dart';

// data -> repositories
export 'data/repositories/movie_repository_impl.dart';

// domain -> entities
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';

// domain -> repositories
export 'domain/repositories/movie_repository.dart';

// domain -> usecases
export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';
export 'domain/usecases/search_movies.dart';

// presentation -> bloc
export 'presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
export 'presentation/bloc/now_play_movie_bloc/now_play_movie_bloc.dart';
export 'presentation/bloc/popular_movie_bloc/popular_movie_bloc.dart';
export 'presentation/bloc/recommendation_movie_bloc/recommendation_movie_bloc.dart';
export 'presentation/bloc/movie_search_bloc/search_bloc.dart';
export 'presentation/bloc/top_rated_movie_bloc/top_rated_movie_bloc.dart';
export 'presentation/bloc/watchlist_movie_bloc/watchlist_movie_bloc.dart';

// presentation -> pages
export 'presentation/pages/movie_detail_page.dart';
export 'presentation/pages/home_movie_page.dart';
export 'presentation/pages/popular_movies_page.dart';
export 'presentation/pages/search_movies_page.dart';
export 'presentation/pages/top_rated_movies_page.dart';
export 'presentation/pages/watchlist_movies_page.dart';

// presentation -> widgets
export 'presentation/widgets/movie_card_list.dart';
