import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

/// A simple container that represents an entry in the cart: a Sandwich + qty.
class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem({required this.sandwich, required this.quantity});
}

/// Cart manages a small collection of sandwiches and quantities.
///
/// Internally it keys items by the sandwich "signature" (type + size + bread)
/// so adding the same sandwich (same properties) increments quantity instead
/// of adding duplicate entries. Pricing is delegated to [PricingRepository].
class Cart {
  final Map<String, CartItem> _items = {};

  Cart();

  // Helper to compute a stable key for a sandwich.
  String _keyFor(Sandwich s) =>
      '${s.type.name}_${s.isFootlong}_${s.breadType.name}';

  /// All cart items.
  List<CartItem> get items => _items.values.toList(growable: false);

  /// Whether the cart is empty.
  bool get isEmpty => _items.isEmpty;

  /// Number of distinct entries in the cart.
  int get length => _items.length;

  /// Total count of sandwiches (sum of quantities).
  int get totalQuantity => _items.values.fold(0, (p, e) => p + e.quantity);

  /// Add [quantity] of [sandwich] to the cart. If the sandwich is already
  /// present (same type/size/bread) the quantity is incremented.
  void add(Sandwich sandwich, {int quantity = 1}) {
    final key = _keyFor(sandwich);
    final existing = _items[key];
    if (existing != null) {
      existing.quantity += quantity;
    } else {
      _items[key] = CartItem(sandwich: sandwich, quantity: quantity);
    }
  }

  /// Set the quantity for [sandwich]. If the quantity is <= 0 the item is removed.
  void updateQuantity(Sandwich sandwich, int quantity) {
    final key = _keyFor(sandwich);
    if (quantity <= 0) {
      _items.remove(key);
      return;
    }
    final existing = _items[key];
    if (existing != null) {
      existing.quantity = quantity;
    } else {
      _items[key] = CartItem(sandwich: sandwich, quantity: quantity);
    }
  }

  /// Remove the sandwich entry entirely.
  void remove(Sandwich sandwich) {
    final key = _keyFor(sandwich);
    _items.remove(key);
  }

  /// Clear the cart.
  void clear() => _items.clear();

  /// Returns the quantity for a given sandwich (0 if not present).
  int quantityFor(Sandwich sandwich) {
    final key = _keyFor(sandwich);
    return _items[key]?.quantity ?? 0;
  }

  /// Calculate the total price for the cart using the provided pricing
  /// repository as the single source of truth for pricing logic.
  double totalPrice(PricingRepository pricingRepository) {
    double total = 0.0;
    for (final item in _items.values) {
      total += pricingRepository.calculatePrice(
        quantity: item.quantity,
        isFootlong: item.sandwich.isFootlong,
      );
    }
    return total;
  }
}
