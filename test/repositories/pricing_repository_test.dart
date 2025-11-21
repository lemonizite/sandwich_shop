import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    final pricing = const PricingRepository();

    test('unit prices are correct', () {
      expect(pricing.unitPrice(isFootlong: false), 7.0);
      expect(pricing.unitPrice(isFootlong: true), 11.0);
    });

    test('total price for zero quantity is 0.0', () {
      expect(pricing.totalPrice(quantity: 0, isFootlong: true), 0.0);
      expect(pricing.totalPrice(quantity: 0, isFootlong: false), 0.0);
    });

    test('total price calculation for multiple quantities', () {
      expect(pricing.totalPrice(quantity: 2, isFootlong: false), 14.0);
      expect(pricing.totalPrice(quantity: 3, isFootlong: true), 33.0);
    });
  });
}
