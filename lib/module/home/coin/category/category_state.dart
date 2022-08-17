import '../../../../data/model/_model.dart';

class CategoryState {
  final bool loading;
  final List<Category>? categories;

  const CategoryState({this.loading = false, this.categories});

  CategoryState copyWith({bool? loading, List<Category>? categories}) {
    return CategoryState(
      loading: loading ?? this.loading,
      categories: categories ?? this.categories,
    );
  }
}
