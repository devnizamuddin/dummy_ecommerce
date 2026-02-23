import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetPaginatedProductsUsecase {
  final ProductRepository repository;

  GetPaginatedProductsUsecase({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call({
    int? limit,
    int? skip,
  }) async {
    return await repository.getPaginatedProducts(limit: limit, skip: skip);
  }
}
