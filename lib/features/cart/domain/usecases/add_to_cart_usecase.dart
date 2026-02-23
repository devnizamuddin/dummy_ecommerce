import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class AddToCartUsecase {
  final CartRepository repository;

  AddToCartUsecase({required this.repository});

  Future<Either<Failure, List<CartEntity>>> call(CartEntity cartItem) async {
    return await repository.addCartItem(cartItem);
  }
}
