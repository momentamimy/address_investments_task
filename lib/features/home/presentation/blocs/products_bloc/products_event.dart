part of 'products_bloc.dart';

@immutable
sealed class ProductsEvent {}

class FetchAllProductsEvent extends ProductsEvent {
  final FetchProductsParams params;

  FetchAllProductsEvent({required this.params});
}
