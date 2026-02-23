part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductEntity> products;

  ProductLoaded(this.products);
}

final class ProductCategoryLoaded extends ProductState {
  final List<CategoryEntity> categories;

  ProductCategoryLoaded(this.categories);
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

