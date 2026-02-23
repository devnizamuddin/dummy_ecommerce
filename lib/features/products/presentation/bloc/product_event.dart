part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class GetAllProductsEvent extends ProductEvent {}

final class GetPaginatedProductsEvent extends ProductEvent {
  final int? limit;
  final int? skip;

  GetPaginatedProductsEvent({this.limit, this.skip});
}

final class GetProductsByCategoryEvent extends ProductEvent {
  final String category;

  GetProductsByCategoryEvent({required this.category});
}

final class LoadMoreProductsEvent extends ProductEvent {}
