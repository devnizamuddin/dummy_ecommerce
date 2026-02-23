import '../../../../dependency_handler.dart';
import '../../domain/entities/cart_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_all_cart_item_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_item_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<GetAllCartItemsEvent>(_onGetAllCartItems);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemEvent>(_onUpdateCartItem);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onGetAllCartItems(
    GetAllCartItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final getAllCartItems = getIt<GetAllCartItemUsecase>();
    final result = await getAllCartItems();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItems) => emit(CartLoaded(cartItems)),
    );
  }

  Future<void> _onAddToCart(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final addToCart = getIt<AddToCartUsecase>();
    final result = await addToCart(event.cartItem);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItems) {
        emit(CartItemAdded(event.cartItem));
        emit(CartLoaded(cartItems));
      },
    );
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final removeFromCart = getIt<RemoveFromCartUsecase>();
    final result = await removeFromCart(event.cartItem);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItems) {
        emit(CartItemRemoved(event.cartItem.id));
        emit(CartLoaded(cartItems));
      },
    );
  }

  Future<void> _onUpdateCartItem(
    UpdateCartItemEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final updateCartItem = getIt<UpdateCartItemUsecase>();
    final result = await updateCartItem(event.cartItem);
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (cartItems) {
        emit(CartItemUpdated(event.cartItem));
        emit(CartLoaded(cartItems));
      },
    );
  }

  Future<void> _onClearCart(
    ClearCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    final clearCart = getIt<ClearCartUsecase>();
    final result = await clearCart();
    result.fold(
      (failure) => emit(CartError(failure.message)),
      (_) {
        emit(CartCleared());
        emit(CartLoaded(const []));
      },
    );
  }
}
