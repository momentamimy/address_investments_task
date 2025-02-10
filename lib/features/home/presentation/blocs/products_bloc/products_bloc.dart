import '../../../data/models/product_model.dart';
import '../../params/fetch_products_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/home_repository.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final HomeRepository _homeRepository;

  ProductsBloc({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(ProductsInitial()) {
    on<FetchAllProductsEvent>(_onFetchCategories);
  }

  _onFetchCategories(FetchAllProductsEvent event, emit) async {
    emit(FetchProductsProgress());
    final result = await _homeRepository.fetchAllProducts(params: event.params);
    await result.fold((failure) async {
      emit(FetchProductsError(error: failure.message));
    }, (products) async {
      emit(FetchProductsComplete(products: products));
    });
  }
}
