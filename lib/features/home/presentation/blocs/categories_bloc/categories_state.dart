part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

class FetchCategoriesProgress extends CategoriesState {}

class FetchCategoriesComplete extends CategoriesState {
  final List<CategoryModel> categories;

  FetchCategoriesComplete({required this.categories});
}

class FetchCategoriesError extends CategoriesState {
  final String error;

  FetchCategoriesError({required this.error});
}