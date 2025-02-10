import 'package:address_investments_task/features/home/data/models/product_model.dart';
import 'package:address_investments_task/features/home/data/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../params/update_product_params.dart';

class UpdateProductCubit extends Cubit<ProductModel> {
  final HomeRepository _homeRepository;

  UpdateProductCubit(super.initialState,
      {required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  Future<void> updateProduct({required UpdateProductParams params}) async {
    final result = await _homeRepository.updateProduct(params: params);
    result.fold(
      (l) => emit(state),
      (r) => emit(
        state.copyWith(title: params.title, price: params.price),
      ),
    );
  }
}
