import 'package:address_investments_task/features/home/data/models/product_model.dart';

class CartProduct {
  final ProductModel product;
  final int quantity;

  CartProduct({required this.product, required this.quantity});

  int get totalPrice => product.price * quantity;
}
