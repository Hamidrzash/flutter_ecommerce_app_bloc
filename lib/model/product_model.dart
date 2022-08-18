class ProductModel {
  int id;
  String name;
  String imageUrl;
  double price;
  int rate;
  int inStock;

  ProductModel({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rate,
    required this.inStock,
    required this.id,
  });
}
