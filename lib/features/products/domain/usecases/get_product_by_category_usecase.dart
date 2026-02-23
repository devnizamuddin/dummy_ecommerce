import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductByCategoryUsecase {
  final ProductRepository repository;

  GetProductByCategoryUsecase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call(String category) async {
    return await repository.getProductsByCategory(category);
  }
}