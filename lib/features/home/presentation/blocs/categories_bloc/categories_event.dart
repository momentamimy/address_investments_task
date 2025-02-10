part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {}
class FetchAllCategoriesEvent extends CategoriesEvent{}
