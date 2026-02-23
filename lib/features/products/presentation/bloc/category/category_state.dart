part of 'category_bloc.dart';

@immutable
sealed class CategoryState {
  final CategoryEntity? selectedCategory;

  const CategoryState({this.selectedCategory});
}

final class CategoryInitial extends CategoryState {
  const CategoryInitial({super.selectedCategory});
}

final class CategoryLoading extends CategoryState {
  const CategoryLoading({super.selectedCategory});
}

final class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> categories;

  const CategoryLoaded(this.categories, {super.selectedCategory});
}

final class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message, {super.selectedCategory});
}
