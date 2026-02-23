part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartEntity> cartItems;

  CartLoaded(this.cartItems);
}

final class CartError extends CartState {
  final String message;

  CartError(this.message);
}

final class CartItemAdded extends CartState {
  final CartEntity cartItem;

  CartItemAdded(this.cartItem);
}

final class CartItemRemoved extends CartState {
  final int productId;

  CartItemRemoved(this.productId);
}

final class CartItemUpdated extends CartState {
  final CartEntity cartItem;

  CartItemUpdated(this.cartItem);
}

final class CartCleared extends CartState {}
