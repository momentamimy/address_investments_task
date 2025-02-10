enum AppScreens {
  home(path: "/home"),
  productDetails(path: "/product_details"),
  cart(path: "/cart"),
  orderConfirmation(path: "/order_confirmation"),;

  const AppScreens({required this.path});

  final String path;
}
