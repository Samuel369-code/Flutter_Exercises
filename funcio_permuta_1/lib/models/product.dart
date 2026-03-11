class Product {
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String category; // <-- nueva propiedad


  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category // <-- nueva propiedad
  });
}
