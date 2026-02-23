import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/cart_entity.dart';

import '../repositories/cart_repository.dart';

class GetAllCartItemUsecase {
  final CartRepository repository;

  GetAllCartItemUsecase({required this.repository});

  Future<Either<Failure, List<CartEntity>>> call() async {
    return await repository.getAllCartItems();
  }
}
