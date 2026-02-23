import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../dependency_handler.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/usecases/get_product_category_usecase.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryInitial()) {
    on<GetCategoriesEvent>(_onGetCategories);
    on<SelectCategoryEvent>(_onSelectCategory);
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(CategoryLoading(selectedCategory: state.selectedCategory));
    final getProductCategory = getIt<GetProductCategoryUsecase>();
    final result = await getProductCategory();
    result.fold(
      (failure) => emit(CategoryError(failure.message, selectedCategory: state.selectedCategory)),
      (categories) => emit(CategoryLoaded(categories, selectedCategory: state.selectedCategory)),
    );
  }

  Future<void> _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      emit(CategoryLoaded(currentState.categories, selectedCategory: event.category));
    } else {
      emit(CategoryInitial(selectedCategory: event.category));
    }
  }
}
