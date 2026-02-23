import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() async {
    try {
      final result = await remoteDataSource.getAllProducts();
      return Right(result);
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getPaginatedProducts({
    int? skip,
    int? limit,
  }) async {
    try {
      final result = await remoteDataSource.getPaginatedProducts(
        skip: skip,
        limit: limit,
      );
      return Right(result);
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final result = await remoteDataSource.getProductsByCategory(category);
      return Right(result);
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
}
