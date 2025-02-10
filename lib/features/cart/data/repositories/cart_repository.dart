

import '../../../home/data/models/product_model.dart';
import '../models/cart_product.dart';

abstract class CartRepository {
  Future<bool> addToCart(ProductModel product);
  Future<bool> removeFromCart(int productId);
  Future<bool> increaseProductQuantity(int productId);
  Future<bool> decreaseProductQuantity(int productId);
  Future<List<CartProduct>> getCartProducts();
  Future<bool> clearCart();
}
