part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}
class FetchProductsProgress extends ProductsState {}

class FetchProductsComplete extends ProductsState {
  final List<ProductModel> products;

  FetchProductsComplete({required this.products});
}

class FetchProductsError extends ProductsState {
  final String error;

  FetchProductsError({required this.error});
}