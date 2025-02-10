part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartProductsProgress extends CartState {}

final class CartProductsComplete extends CartState {
  final List<CartProduct> cartProducts;

  final int subTotal;
  final int total;

  CartProductsComplete({
    required this.cartProducts,
    required this.subTotal,
    required this.total,
  });
}
