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
    final response = await apiCommunication.doGetRequest<List<ProductModel>>(
      endpoint: ApiEndpoint.products,
    );
    return response.data;
  }

  @override
  Future<List<ProductModel>> getPaginatedProducts({
    int? limit,
    int? skip,
  }) async {
    final response = await apiCommunication.doGetRequest<List<ProductModel>>(
      endpoint: ApiEndpoint.products,
      queryParameters: {'limit': limit, 'skip': skip},
    );
    return response.data;
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final response = await apiCommunication.doGetRequest<List<ProductModel>>(
      endpoint: ApiEndpoint.products,
      queryParameters: {'category': category},
    );
    return response.data;
  }
}
