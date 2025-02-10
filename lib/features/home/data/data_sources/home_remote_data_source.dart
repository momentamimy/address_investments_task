import 'dart:convert';

import '../../../../core/errors/failures.dart';
import '../../../../core/services/network/network_service.dart';
import '../../../../core/constants/urls_constants.dart';

import '../../presentation/params/update_product_params.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../repositories/home_repository.dart';
import '../../presentation/params/fetch_products_params.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRemoteDataSource extends HomeRepository {
  final NetworkService _networkService;

  HomeRemoteDataSource({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchAllCategories() async {
    try {
      final response = await _networkService.dio.get(
        UrlsConst.categories,
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data;
        return Right(jsonResponse
            .map((categoryJson) => CategoryModel.fromJson(categoryJson))
            .toList());
      }
      return left(ServerFailure());
    } on DioException catch (e) {
      return left(NetworkService.handleDioError(e));
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchAllProducts(
      {required FetchProductsParams params}) async {
    try {
      final response = await _networkService.dio.get(
        "${UrlsConst.products}?offset=${params.offset}&limit=${params.limit}",
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = response.data;
        return Right(jsonResponse
            .map((productJson) => ProductModel.fromJson(productJson))
            .toList());
      }
      return left(ServerFailure());
    } on DioException catch (e) {
      return left(NetworkService.handleDioError(e));
    } catch (e) {
      return left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateProduct(
      {required UpdateProductParams params}) async {
    try {
      final response = await _networkService.dio
          .put("${UrlsConst.products}${params.productId}", data: {
        if (params.title != null) "title": params.title,
        if (params.price != null) "price": params.price
      });
      if (response.statusCode == 200) {
        return Right(true);
      }
      return left(ServerFailure());
    } on DioException catch (e) {
      return left(NetworkService.handleDioError(e));
    } catch (e) {
      return left(UnknownFailure());
    }
  }
}
