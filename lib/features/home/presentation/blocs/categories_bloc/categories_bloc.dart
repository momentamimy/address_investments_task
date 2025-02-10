import '../../../data/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/category_model.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final HomeRepository _homeRepository;

  CategoriesBloc({required HomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(CategoriesInitial()) {
    on<FetchAllCategoriesEvent>(_onFetchCategories);
  }

  _onFetchCategories(FetchAllCategoriesEvent event, emit) async {
    emit(FetchCategoriesProgress());
    final result = await _homeRepository.fetchAllCategories();
    await result.fold((failure) async {
      emit(FetchCategoriesError(error: failure.message));
    }, (categories) async {
      emit(FetchCategoriesComplete(categories: categories));
    });
  }
}
