part of 'product_details_bloc.dart';

@immutable
sealed class ProductDetailsEvent {}
class AddProductToCartEvent extends ProductDetailsEvent {
  final ProductModel productModel;

  AddProductToCartEvent({required this.productModel});
}
