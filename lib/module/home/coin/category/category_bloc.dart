import 'package:bloc/bloc.dart';

import '../../../../data/provider/category_provider.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late final CategoryProvider categoryProvider;

  CategoryBloc() : super(const CategoryState()) {
    categoryProvider = CategoryProvider();

    on<LoadCategoryEvent>(onLoadCategoriesEvent);

    add(LoadCategoryEvent());
  }

  Future onLoadCategoriesEvent(LoadCategoryEvent event, Emitter emit) async {
    try {
      emit(state.copyWith(loading: true));
      emit(state.copyWith(categories: await categoryProvider.getCategories()));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
