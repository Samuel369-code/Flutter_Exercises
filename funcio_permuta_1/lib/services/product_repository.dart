// services/product_repository.dart
import '../models/product.dart';

class ProductRepository {
  static List<Product> products = [
    Product(
      name: 'Skincare serum',
      description: 'Skincare',
      imageUrl: "assets/images/products/DTC_skincare_Serum.webp",
      price: 20.99,
      category: 'Skin Care',

    ),
    Product(
      name: 'Skincare Gel',
      description: '',
      imageUrl: "assets/images/products/DTC_skincare_Gel.png.webp",
      price: 23.2,
      category: 'Skin Care',

    ),
    Product(
      name: 'Skincare Cream',
      description: 'Skincare Recovery',
      imageUrl: "assets/images/products/DTC_skincare_Cream.png",
      price: 15.0,
      category: 'Skin Care',

    ),
    Product(
      name: 'Shampoo Recovery',
      description: '',
      imageUrl: "assets/images/products/FOB-PDP-Recovery-SHAMPOO.webp",
      price: 15.95,
      category: 'Hair Care',
    ),
    Product(
      name: 'Body Milk',
      description: '',
      imageUrl: "assets/images/products/DTC_bodycare_cream.webp",
      price: 22.30,
      category: 'Body Care',
    ),
    Product(
      name: 'Body Spray',
      description: '',
      imageUrl: "assets/images/products/DTC_spray.webp",
      price: 22.30,
      category: 'Body Care',
    )
  ];

  // Opcional: método para obtener productos (podría venir de una API en el futuro)
  static List<Product> getAllProducts() {
    return products;
  }
  // Obtener productos filtrados por categoría
  static List<Product> getByCategory(String category) {
    return products
        .where((p) => p.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
