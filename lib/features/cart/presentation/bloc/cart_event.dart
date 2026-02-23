part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class GetAllCartItemsEvent extends CartEvent {}

final class AddToCartEvent extends CartEvent {
  final CartEntity cartItem;

  AddToCartEvent({required this.cartItem});
}

final class RemoveFromCartEvent extends CartEvent {
  final CartEntity cartItem;

  RemoveFromCartEvent({required this.cartItem});
}

final class UpdateCartItemEvent extends CartEvent {
  final CartEntity cartItem;

  UpdateCartItemEvent({required this.cartItem});
}

final class ClearCartEvent extends CartEvent {}
