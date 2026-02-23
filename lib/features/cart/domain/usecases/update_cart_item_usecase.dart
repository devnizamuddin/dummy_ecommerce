import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';
import '../repositories/cart_repository.dart';

class UpdateCartItemUsecase {
  final CartRepository repository;

  UpdateCartItemUsecase({required this.repository});

  Future<Either<Failure, List<CartEntity>>> call(CartEntity cartItem) async {
    return await repository.updateCartItem(cartItem);
  }
}
