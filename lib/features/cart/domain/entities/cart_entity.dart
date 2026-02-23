class CartEntity {
  final int id;
  final String title;
  final String image;
  final int quantity;
  final double price;

  CartEntity({
    required this.id,
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
  });
}
