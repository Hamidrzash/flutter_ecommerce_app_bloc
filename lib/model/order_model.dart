class OrderModel {
  int id;
  String name;
  String imageUrl;
  double price;
  String color;
  int inStock;
  int count;

  OrderModel({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.color,
    required this.inStock,
    required this.count,
    required this.id
  });
}
