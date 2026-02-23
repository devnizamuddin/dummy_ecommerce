import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
  Future<Either<Failure, List<ProductEntity>>> getPaginatedProducts({
    int? limit,
    int? skip,
  });

  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  );
}
