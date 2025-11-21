import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('Cart', () {
    final pricing = PricingRepository();

    test('adding items increases total quantity and items list', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.white);

      cart.add(s1);
      expect(cart.totalQuantity, 1);
      expect(cart.items.length, 1);

      // Adding same sandwich increments quantity
      cart.add(s1, quantity: 2);
      expect(cart.totalQuantity, 3);
      expect(cart.quantityFor(s1), 3);
    });

    test('updateQuantity and remove behave correctly', () {
      final cart = Cart();
      final s1 = Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: true,
          breadType: BreadType.wheat);
      cart.add(s1, quantity: 2);
      expect(cart.quantityFor(s1), 2);

      cart.updateQuantity(s1, 5);
      expect(cart.quantityFor(s1), 5);

      cart.updateQuantity(s1, 0);
      expect(cart.quantityFor(s1), 0);
      expect(cart.isEmpty, true);
    });

    test('totalPrice uses PricingRepository', () {
      final cart = Cart();
      final sixInch = Sandwich(
          type: SandwichType.tunaMelt,
          isFootlong: false,
          breadType: BreadType.white);
      final footlong = Sandwich(
          type: SandwichType.meatballMarinara,
          isFootlong: true,
          breadType: BreadType.wheat);

      cart.add(sixInch, quantity: 2); // 2 * 7 = 14
      cart.add(footlong, quantity: 1); // 1 * 11 = 11

      final total = cart.totalPrice(pricing);
      expect(total, 25.0);
    });
  });
}
