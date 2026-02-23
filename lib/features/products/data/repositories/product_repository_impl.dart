import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

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
    } catch (exception, stackTrace) {
      debugPrint('Error: $exception, StackTrace: $stackTrace');
      return Left(ServerFailure(message: 'Failed to get all products'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getPaginatedProducts({
    int? limit,
    int? skip,
  }) async {
    try {
      final result = await remoteDataSource.getPaginatedProducts(
        limit: limit,
        skip: skip,
      );
      return Right(result);
    } catch (exception, stackTrace) {
      debugPrint('Error: $exception, StackTrace: $stackTrace');
      return Left(ServerFailure(message: 'Failed to get paginated products'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final result = await remoteDataSource.getProductsByCategory(category);
      return Right(result);
    } catch (exception, stackTrace) {
      debugPrint('Error: $exception, StackTrace: $stackTrace');
      return Left(ServerFailure(message: 'Failed to get products by category'));
    }
  }
}
