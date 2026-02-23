import 'package:dummy_ecommerce/features/products/domain/usecases/get_product_category_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/services/api_communication.dart';
import 'core/services/local_storage_service.dart';
import 'features/cart/data/datasources/cart_local_data_source.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'features/cart/domain/usecases/clear_cart_usecase.dart';
import 'features/cart/domain/usecases/get_all_cart_item_usecase.dart';
import 'features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'features/cart/domain/usecases/update_cart_item_usecase.dart';
import 'features/products/data/datasources/category_remote_data_source.dart';
import 'features/products/data/datasources/product_remote_datasource.dart';
import 'features/products/data/repositories/category_repository_impl.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/category_repository.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/get_all_products_usecase.dart';
import 'features/products/domain/usecases/get_paginated_products_usecase.dart';
import 'features/products/domain/usecases/get_product_by_category_usecase.dart';

final getIt = GetIt.instance;

Future<void> initializeApp() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<LocalStorageService>(() => LocalStorageService(preferences: sharedPreferences));
  getIt.registerLazySingleton<ApiCommunication>(() => ApiCommunication());
  _initProducts();
  _initCategories();
  _initCart();
}

void _initCart() {
  getIt.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(localStorageService: getIt<LocalStorageService>()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(remoteDataSource: getIt<CartLocalDataSource>()),
  );
  getIt.registerLazySingleton<GetAllCartItemUsecase>(
    () => GetAllCartItemUsecase(repository: getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<AddToCartUsecase>(
    () => AddToCartUsecase(repository: getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<RemoveFromCartUsecase>(
    () => RemoveFromCartUsecase(repository: getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<UpdateCartItemUsecase>(
    () => UpdateCartItemUsecase(repository: getIt<CartRepository>()),
  );
  getIt.registerLazySingleton<ClearCartUsecase>(
    () => ClearCartUsecase(repository: getIt<CartRepository>()),
  );
}

void _initProducts() {
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiCommunication: getIt<ApiCommunication>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: getIt<ProductRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetAllProductsUsecase>(
    () => GetAllProductsUsecase(repository: getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetPaginatedProductsUsecase>(
    () => GetPaginatedProductsUsecase(repository: getIt<ProductRepository>()),
  );
  getIt.registerLazySingleton<GetProductByCategoryUsecase>(
    () => GetProductByCategoryUsecase(repository: getIt<ProductRepository>()),
  );
}

void _initCategories() {
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(apiCommunication: getIt<ApiCommunication>()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(remoteDataSource: getIt<CategoryRemoteDataSource>()),
  );
  getIt.registerLazySingleton<GetProductCategoryUsecase>(
    () => GetProductCategoryUsecase(repository: getIt<CategoryRepository>()),
  );
}
