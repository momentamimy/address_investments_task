import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/cart_product.dart';
import '../../data/repositories/cart_repository.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _repository;

  CartBloc({required CartRepository cartRepository})
      : _repository = cartRepository,
        super(CartInitial()) {
    on<FetchCartProductsEvent>(_onFetchCartProductsEvent);
  }

  List<CartProduct> cartProducts = <CartProduct>[];

  _onFetchCartProductsEvent(
      FetchCartProductsEvent event, Emitter<CartState> emit) async {
    emit(CartProductsProgress());
    cartProducts = await _repository.getCartProducts();
    emit(CartProductsComplete(
      cartProducts: cartProducts,
      subTotal: _subTotal,
      total: _total,
    ));
  }

  Future<void> removeFromCart(int productId) async {
    await _repository.removeFromCart(productId);
    add(FetchCartProductsEvent());
  }

  Future<void> increaseProductQuantity(int productId) async {
    await _repository.increaseProductQuantity(productId);
    add(FetchCartProductsEvent());
  }

  Future<void> decreaseProductQuantity(int productId) async {
    await _repository.decreaseProductQuantity(productId);
    add(FetchCartProductsEvent());
  }

  checkout() async {
    await _repository.clearCart();
    add(FetchCartProductsEvent());
  }

  int get _subTotal {
    double subTotal = 0.0;
    for (var cartProduct in cartProducts) {
      subTotal += cartProduct.product.price * cartProduct.quantity;
    }
    return subTotal.round();
  }

  int get _total => _subTotal == 0 ? 0 : _subTotal + 10;
}
