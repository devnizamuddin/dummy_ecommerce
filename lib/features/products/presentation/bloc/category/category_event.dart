part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class GetCategoriesEvent extends CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final CategoryEntity? category; // null means 'All'

  SelectCategoryEvent(this.category);
}
