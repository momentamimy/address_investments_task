import '../../../../core/services/storage/hive_utils.dart';
import '../models/cart_product.dart';
import '../repositories/cart_repository.dart';

class CartLocalDataSource extends CartRepository {
  @override
  Future<bool> addToCart(product) async {
    final productBox = await HiveUtils.getProductBox();
    final cartProductQuantityBox = await HiveUtils.getCartProductQuantityBox();

    try {
      await productBox.put(
        '${product.id}',
        product,
      );
      final int productQuantity =
          cartProductQuantityBox.get("${product.id}") ?? 0;
      await cartProductQuantityBox.put(
        "${product.id}",
        productQuantity + 1,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> removeFromCart(int productId) async {
    final productBox = await HiveUtils.getProductBox();
    final cartProductQuantityBox = await HiveUtils.getCartProductQuantityBox();

    try {
      await productBox.delete('$productId');
      await cartProductQuantityBox.delete("$productId");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> increaseProductQuantity(int productId) async {
    try {
      final cartProductQuantityBox =
          await HiveUtils.getCartProductQuantityBox();
      final int productQuantity = cartProductQuantityBox.get("$productId") ?? 0;
      await cartProductQuantityBox.put(
        "$productId",
        productQuantity + 1,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> decreaseProductQuantity(int productId) async {
    try {
      final cartProductQuantityBox =
          await HiveUtils.getCartProductQuantityBox();
      final int productQuantity = cartProductQuantityBox.get("$productId") ?? 0;
      await cartProductQuantityBox.put(
        "$productId",
        productQuantity - 1,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<CartProduct>> getCartProducts() async {
    final productBox = await HiveUtils.getProductBox();
    final cartProductQuantityBox = await HiveUtils.getCartProductQuantityBox();
    if (productBox.values.isEmpty) {
      return [];
    }
    return productBox.values.map((product) {
      final quantity = cartProductQuantityBox.get("${product.id}") ?? 0;
      return CartProduct(product: product, quantity: quantity);
    }).toList();
  }

  @override
  Future<bool> clearCart() async {
    try {
      final productBox = await HiveUtils.getProductBox();
      final cartProductQuantityBox =
          await HiveUtils.getCartProductQuantityBox();
      await productBox.clear();
      await cartProductQuantityBox.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
