import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_handler.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_paginated_products_usecase.dart';
import '../../domain/usecases/get_product_by_category_usecase.dart';
import '../../domain/usecases/get_product_category_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<GetPaginatedProductsEvent>(_onGetPaginatedProducts);
    on<GetProductCategoryEvent>(_onGetProductCategory);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
  }

  Future<void> _onGetAllProducts(
    GetAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final getAllProducts = getIt<GetAllProductsUsecase>();
    final result = await getAllProducts();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onGetPaginatedProducts(
    GetPaginatedProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final getPaginatedProducts = getIt<GetPaginatedProductsUsecase>();
    final result = await getPaginatedProducts(limit: event.limit, skip: event.skip);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onGetProductCategory(
    GetProductCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final getProductCategory = getIt<GetProductCategoryUsecase>();
    final result = await getProductCategory();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductCategoryLoaded(products)),
    );
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final getProductsByCategory = getIt<GetProductByCategoryUsecase>();  
    final result = await getProductsByCategory(event.category);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
