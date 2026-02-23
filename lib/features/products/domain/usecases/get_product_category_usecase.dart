import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';
import '../repositories/category_repository.dart';

class GetProductCategoryUsecase {
  final CategoryRepository repository;

  GetProductCategoryUsecase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await repository.getAllCategories();
  }
}