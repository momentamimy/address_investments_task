import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/data/repositories/cart_repository.dart';
import '../../../home/data/models/product_model.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final CartRepository _repository;

  ProductDetailsBloc({required CartRepository cartRepository})
      : _repository = cartRepository,
        super(ProductDetailsInitial()) {
    on<AddProductToCartEvent>(_onAddToCart);
  }

  _onAddToCart(
      AddProductToCartEvent event, Emitter<ProductDetailsState> emit) async {
    emit(AddToCartProgress());
    final res = await _repository.addToCart(event.productModel);
    if (res) {
      emit(AddToCartComplete());
    } else {
      emit(AddToCartError());
    }
  }
}
