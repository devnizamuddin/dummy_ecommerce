import 'package:dummy_ecommerce/core/constant/api_endpoint.dart';

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
    if (response.isSuccess) {
      return response.data.map((x) => CategoryModel.fromJson(x)).toList();
    } else {
      throw Exception('Data parsing error');
    }
  }
}
