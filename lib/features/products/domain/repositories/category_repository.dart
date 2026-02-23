import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getAllCategories();
}