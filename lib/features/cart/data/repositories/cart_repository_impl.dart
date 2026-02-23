import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource remoteDataSource;

  CartRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CartEntity>>> getAllCartItems() async {
    try {
      final result = await remoteDataSource.getAllCartItems();
      return Right(result.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> addCartItem(CartEntity cartItem) async {
    try {
      final result = await remoteDataSource.addCartItem(
        CartModel(
          id: cartItem.id,
          title: cartItem.title,
          image: cartItem.image,
          quantity: cartItem.quantity,
          price: cartItem.price,
        ),
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> removeCartItem(CartEntity cartItem) async {
    try {
      final result = await remoteDataSource.removeCartItem(
        CartModel(
          id: cartItem.id,
          title: cartItem.title,
          image: cartItem.image,
          quantity: cartItem.quantity,
          price: cartItem.price,
        ),
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> updateCartItem(CartEntity cartItem) async {
    try {
      final result = await remoteDataSource.updateCartItem(
        CartModel(
          id: cartItem.id,
          title: cartItem.title,
          image: cartItem.image,
          quantity: cartItem.quantity,
          price: cartItem.price,
        ),
      );
      return Right(result.map((e) => e.toEntity()).toList());
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await remoteDataSource.clearCart();
      return const Right(null);
    } on AppException catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
}
