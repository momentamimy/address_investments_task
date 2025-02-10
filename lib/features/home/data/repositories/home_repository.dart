import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

import '../../presentation/params/fetch_products_params.dart';

import '../../presentation/params/update_product_params.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryModel>>> fetchAllCategories();

  Future<Either<Failure, List<ProductModel>>> fetchAllProducts(
      {required FetchProductsParams params});

  Future<Either<Failure, bool>> updateProduct(
      {required UpdateProductParams params});
}
