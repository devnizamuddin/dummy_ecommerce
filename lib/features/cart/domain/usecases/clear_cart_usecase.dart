import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/cart_repository.dart';

class ClearCartUsecase {
  final CartRepository repository;

  ClearCartUsecase({required this.repository});

  Future<Either<Failure, void>> call() async {
    return await repository.clearCart();
  }
}
