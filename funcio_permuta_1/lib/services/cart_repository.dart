// services/cart_repository.dart
import '../models/product.dart';

class CartRepository {
  static final Map<Product, int> _cart = {};

  static Map<Product, int> getCart() => _cart;

  static List<Product> getCartItems() => _cart.keys.toList();

  static void addToCart(Product product, {int quantity = 1}) {
    if (_cart.containsKey(product)) {
      _cart[product] = _cart[product]! + quantity;
    } else {
      _cart[product] = quantity;
    }
  }

  static void removeFromCart(Product product) {
    _cart.remove(product);
  }

  static void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      _cart.remove(product);
    } else {
      _cart[product] = quantity;
    }
  }

  static int getQuantity(Product product) => _cart[product] ?? 0;

  static double getTotalPrice() {
    double total = 0;
    _cart.forEach((product, qty) {
      total += product.price * qty;
    });
    return total;
  }

  static void clearCart() {
    _cart.clear();
  }
}
