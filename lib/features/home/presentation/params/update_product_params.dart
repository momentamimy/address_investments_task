class UpdateProductParams {
  final int productId;
  final String? title;
  final int? price;

  UpdateProductParams(
      {required this.productId, required this.title, required this.price});
}
