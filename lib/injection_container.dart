
import 'package:get_it/get_it.dart';
import 'core/services/network/network_service.dart';
import 'features/cart/data/data_sources/cart_local_data_source.dart';
import 'features/cart/data/repositories/cart_repository.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/home/data/data_sources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository.dart';
import 'features/home/presentation/blocs/categories_bloc/categories_bloc.dart';
import 'features/home/presentation/blocs/products_bloc/products_bloc.dart';
import 'features/product_details/presentation/bloc/product_details_bloc.dart';

class AppDependencies {
  static final sl = GetIt.instance;

  AppDependencies._();

  static Future<void> initAppInjections() async {
    /// Features
    _injectBlocs();
    _injectRepositories();

    /// Services
    sl.registerLazySingleton<NetworkService>(() => NetworkService());
  }

  static void _injectBlocs() {
    sl.registerFactory(() => CategoriesBloc(homeRepository: sl()));
    sl.registerFactory(() => ProductsBloc(homeRepository: sl()));
    sl.registerFactory(() => ProductDetailsBloc(cartRepository: sl()));
    sl.registerFactory(() => CartBloc(cartRepository: sl()));
  }

  static void _injectRepositories() {
    sl.registerLazySingleton<HomeRepository>(
        () => HomeRemoteDataSource(networkService: sl()));
    sl.registerLazySingleton<CartRepository>(() => CartLocalDataSource());
  }
}
