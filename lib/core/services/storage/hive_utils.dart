import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../features/cart/data/models/cart_product.dart';
import '../../../features/home/data/models/category_model.dart';
import '../../../features/home/data/models/product_model.dart';

class HiveUtils {
  static const _hiveDBName = "hive_db";

  static initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.initFlutter(_hiveDBName);

    Hive.registerAdapter<CategoryModel>(CategoryModelAdapter());
    Hive.registerAdapter<ProductModel>(ProductModelAdapter());
  }

  static Future<Box<ProductModel>> getProductBox() async {
    final boxName = HiveBoxes.productsBoxes.name;
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<ProductModel>(boxName,);
    }
    return Hive.box<ProductModel>(boxName);
  }
  static Future<Box<int>> getCartProductQuantityBox() async {
    final boxName = HiveBoxes.cartProductQuantityBoxes.name;
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<int>(boxName,);
    }
    return Hive.box<int>(boxName);
  }

  static Future<bool> addToCart(product) async {
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

  static Future<bool> removeFromCart(int productId) async {
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

  static Future<bool> increaseProductQuantity(int productId) async {
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

  static Future<bool> decreaseProductQuantity(int productId) async {
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

  static Future<List<CartProduct>> getCartProducts() async {
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


  static closeHive() {
    Hive.close();
  }
}

enum HiveBoxes {
  productsBoxes,
  cartProductQuantityBoxes;
}
