library tv_series;



// data -> datasources
export 'data/datasources/tv_local_data_source.dart';
export 'data/datasources/tv_remote_data_source.dart';

// data -> models
export 'data/models/created_by_model.dart';
export 'data/models/production_coutry_model.dart';
export 'data/models/spoken_language_model.dart';
export 'data/models/te_episode_to_air_model.dart';
export 'data/models/tv_detail_model.dart';
export 'data/models/tv_model.dart';
export 'data/models/tv_response.dart';
export 'data/models/tv_table.dart';

// data -> repositories
export 'data/repositories/tv_repository_impl.dart';

// domain -> entities
export 'domain/entities/created_by.dart';
export 'domain/entities/production_country.dart';
export 'domain/entities/te_episode_to_air.dart';
export 'domain/entities/spoken_language.dart';
export 'domain/entities/tv.dart';
export 'domain/entities/tv_detail.dart';


// domain -> repositories
export 'domain/repositories/tv_repository.dart';

// domain -> usecases
export 'domain/usecases/get_on_the_air_tv.dart';
export 'domain/usecases/get_popular_tv.dart';
export 'domain/usecases/get_top_rated_tv.dart';
export 'domain/usecases/get_tv_detail.dart';
export 'domain/usecases/get_tv_recommendation.dart';
export 'domain/usecases/get_watchlist_tv.dart';
export 'domain/usecases/get_watchlist_tv_status.dart';
export 'domain/usecases/remove_tv_watchlist.dart';
export 'domain/usecases/save_tv_watchlist.dart';
export 'domain/usecases/search_tv.dart';

// presentation -> pages
export 'presentation/pages/home_tv_page.dart';
export 'presentation/pages/on_the_air_tv_page.dart';
export 'presentation/pages/popular_tv_page.dart';
export 'presentation/pages/search_tv_page.dart';
export 'presentation/pages/top_rated_page.dart';
export 'presentation/pages/tv_detail_page.dart';
export 'presentation/pages/watchlist_tv_page.dart';

// presentation -> bloc
export 'presentation/bloc/tv_detail_bloc/tv_detail_bloc.dart';
export 'presentation/bloc/on_the_air_tv_bloc/on_the_air_tv_bloc.dart';
export 'presentation/bloc/popular_tv_bloc/popular_tv_bloc.dart';
export 'presentation/bloc/recommendation_tv_bloc/recommendation_tv_bloc.dart';
export 'presentation/bloc/tv_search_bloc/tv_search_bloc.dart';
export 'presentation/bloc/top_rated_tv_bloc/top_rated_tv_bloc.dart';
export 'presentation/bloc/watchlist_tv_bloc/watchlist_tv_bloc.dart';

// presentation -> widgets
export 'presentation/widgets/tv_card_list.dart';