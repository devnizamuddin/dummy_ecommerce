import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class RemoveFromCartUsecase {
  final CartRepository repository;

  RemoveFromCartUsecase({required this.repository});

  Future<Either<Failure, List<CartEntity>>> call(CartEntity cartItem) async {
    return await repository.removeCartItem(cartItem);
  }
}
