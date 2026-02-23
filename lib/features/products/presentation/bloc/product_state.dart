part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  final bool hasReachedMax;
  final bool isFetchingMore;

  ProductLoaded({
    required this.products,
    this.hasReachedMax = false,
    this.isFetchingMore = false,
  });

  ProductLoaded copyWith({
    List<ProductEntity>? products,
    bool? hasReachedMax,
    bool? isFetchingMore,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}

final class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}
