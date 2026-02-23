import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getAllCartItems();
  Future<Either<Failure, List<CartEntity>>> addCartItem(CartEntity cartItem);
  Future<Either<Failure, List<CartEntity>>> removeCartItem(CartEntity cartItem);
  Future<Either<Failure, List<CartEntity>>> updateCartItem(CartEntity cartItem);
  Future<Either<Failure, void>> clearCart();
}
