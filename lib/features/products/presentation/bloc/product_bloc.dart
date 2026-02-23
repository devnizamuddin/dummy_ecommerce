import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_handler.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_paginated_products_usecase.dart';
import '../../domain/usecases/get_product_by_category_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  int skip = 0;
  int limit = 10;
  String? currentCategory;
  bool isFetching = false;

  ProductBloc() : super(ProductInitial()) {
    on<GetAllProductsEvent>(_onGetAllProducts);
    on<GetPaginatedProductsEvent>(_onGetPaginatedProducts);
    on<GetProductsByCategoryEvent>(_onGetProductsByCategory);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
  }

  Future<void> _onGetAllProducts(
    GetAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    isFetching = true;
    currentCategory = null;
    emit(ProductLoading());
    final getAllProducts = getIt<GetAllProductsUsecase>();
    final result = await getAllProducts();
    result.fold(
      (failure) {
        isFetching = false;
        emit(ProductError(failure.message));
      },
      (products) {
        isFetching = false;
        emit(ProductLoaded(products: products, hasReachedMax: true));
      },
    );
  }

  Future<void> _onGetPaginatedProducts(
    GetPaginatedProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    isFetching = true;
    currentCategory = null;
    limit = event.limit ?? 10;
    skip = event.skip ?? 0;
    emit(ProductLoading());
    final getPaginatedProducts = getIt<GetPaginatedProductsUsecase>();
    final result = await getPaginatedProducts(limit: limit, skip: skip);
    result.fold(
      (failure) {
        isFetching = false;
        emit(ProductError(failure.message));
      },
      (products) {
        isFetching = false;
        final hasReachedMax = products.isEmpty || products.length < limit;
        emit(
          ProductLoaded(
            products: products,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
    );
  }

  Future<void> _onGetProductsByCategory(
    GetProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    isFetching = true;
    currentCategory = event.category;
    emit(ProductLoading());
    final getProductsByCategory = getIt<GetProductByCategoryUsecase>();
    final result = await getProductsByCategory(event.category);
    result.fold(
      (failure) {
        isFetching = false;
        emit(ProductError(failure.message));
      },
      (products) {
        isFetching = false;
        emit(ProductLoaded(products: products, hasReachedMax: true));
      },
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    if (isFetching || currentCategory != null) return;

    final currentState = state;
    if (currentState is ProductLoaded && !currentState.hasReachedMax) {
      isFetching = true;
      skip += limit;
      emit(currentState.copyWith(isFetchingMore: true));

      final getPaginatedProducts = getIt<GetPaginatedProductsUsecase>();
      final result = await getPaginatedProducts(limit: limit, skip: skip);

      result.fold(
        (failure) {
          isFetching = false;
          skip -= limit; // Revert skip back to previous value
          emit(ProductError(failure.message));
        },
        (products) {
          isFetching = false;
          final hasReachedMax = products.isEmpty || products.length < limit;
          emit(
            currentState.copyWith(
              products: List.of(currentState.products)..addAll(products),
              hasReachedMax: hasReachedMax,
              isFetchingMore: false,
            ),
          );
        },
      );
    }
  }
}
