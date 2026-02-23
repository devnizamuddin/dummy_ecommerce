import 'package:dummy_ecommerce/core/errors/exception.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/api_endpoint.dart';
import '../../../../core/services/api_communication.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiCommunication apiCommunication;

  CategoryRemoteDataSourceImpl({required this.apiCommunication});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await apiCommunication.doGetRequest(
      endpoint: ApiEndpoint.categories,
    );
    try {
      final List<CategoryModel> categoryList = (response.data as List)
          .map((map) => CategoryModel.fromMap(map as Map<String, dynamic>))
          .toList();
      return categoryList;
    } catch (exception, stackTrace) {
      debugPrint('Error: $exception, StackTrace: $stackTrace');
      throw ModelConversionException(message: 'Failed to parse categoryList');
    }
  }
}
