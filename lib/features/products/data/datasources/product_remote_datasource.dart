import 'package:dummy_ecommerce/core/errors/exception.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/api_endpoint.dart';
import '../../../../core/services/api_communication.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getPaginatedProducts({int? limit, int? skip});
  Future<List<ProductModel>> getProductsByCategory(String category);
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final ApiCommunication apiCommunication;

  ProductRemoteDataSourceImpl({required this.apiCommunication});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await apiCommunication.doGetRequest(
      endpoint: ApiEndpoint.products,
    );
    try {
      final List<ProductModel> products = ((response.data as Map<String, dynamic>)['products'] as List)
          .map((mapData) => ProductModel.fromMap(mapData))
          .toList();
      return products;
    } catch (exception, stackTrace) {
      debugPrint('Error: $exception, StackTrace: $stackTrace');
      throw ModelConversionException(message: 'Failed to parse products');
    }
  }

  @override
  Future<List<ProductModel>> getPaginatedProducts({
    int? limit,
    int? skip,
  }) async {
    final response = await apiCommunication.doGetRequest(
      endpoint: ApiEndpoint.products,
      queryParameters: {'limit': limit, 'skip': skip},
    );

    try {
      final List<ProductModel> products = ((response.data as Map<String, dynamic>)['products'] as List)
          .map((mapData) => ProductModel.fromMap(mapData))
          .toList();
      return products;
    } catch (exception, stackTrace) {
      debugPrint('Error: $exception, StackTrace: $stackTrace');
      throw ModelConversionException(message: 'Failed to parse products');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response = await apiCommunication.doGetRequest(
      endpoint: '${ApiEndpoint.products}/category/$category',
    );
    try {
      final List<ProductModel> products = ((response.data as Map<String, dynamic>)['products'] as List)
          .map((mapData) => ProductModel.fromMap(mapData))
          .toList();
      return products;
    } catch (exception, stackTrace) {
      debugPrint('Error: $exception, StackTrace: $stackTrace');
      throw ModelConversionException(message: 'Failed to parse products');
    }
  }
}
