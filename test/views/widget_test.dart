import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('App widget', () {
    testWidgets('App sets OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen interaction tests', () {
    testWidgets('App widget renders OrderScreen', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });

    testWidgets('Increment button increases quantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Quantity starts at 1, increment to 2
      await tester.tap(find.widgetWithIcon(IconButton, Icons.add).first);
      await tester.pump();
      // Check that quantity has increased to 2
      expect(find.text('2'), findsWidgets);
    });
  });

  group('Group of tests for the OrderItemDisplay widget', () {
    // Check the OrderItemDisplay widgets in isolation.
    testWidgets('Displays the correct text for 0 sandwiches',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        breadType: BreadType.white,
        quantity: 0,
        itemType: 'Footlong',
        orderNote: '',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      // Build the OrderItemDisplay widget to be tested.
      await tester.pumpWidget(testApp);
      expect(find.text('0 white Footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('Displays the correct text and emoji for 3 sandwiches',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        breadType: BreadType.white,
        quantity: 3,
        itemType: 'Footlong',
        orderNote: '',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(
          find.text('3 white Footlong sandwich(es): 🥪🥪🥪'), findsOneWidget);
    });
  });

  group('CartSummary widget tests', () {
    testWidgets('CartSummary displays initial empty cart state',
        (WidgetTester tester) async {
      final cart = Cart();
      final pricingRepository = PricingRepository();

      final testApp = MaterialApp(
        home: Scaffold(
          body: CartSummary(
            cart: cart,
            pricingRepository: pricingRepository,
          ),
        ),
      );

      await tester.pumpWidget(testApp);

      // Verify initial state
      expect(find.text('Cart Summary'), findsOneWidget);
      expect(find.text('Items: 0'), findsOneWidget);
      expect(find.text('\$0.00'), findsOneWidget);
    });

    testWidgets('CartSummary widget displays correct total with items',
        (WidgetTester tester) async {
      final cart = Cart();
      final pricingRepository = PricingRepository();

      // Add items to cart
      final sandwich = Sandwich(
        id: 'test',
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
        description: '',
        available: true,
      );

      cart.add(sandwich, quantity: 2); // 2 * $11.00 = $22.00

      final testApp = MaterialApp(
        home: Scaffold(
          body: CartSummary(
            cart: cart,
            pricingRepository: pricingRepository,
          ),
        ),
      );

      await tester.pumpWidget(testApp);

      // Verify cart summary shows correct totals
      expect(find.text('Items: 2'), findsOneWidget);
      expect(find.text('\$22.00'), findsOneWidget);
    });

    testWidgets(
        'CartSummary widget displays correct total for six-inch sandwiches',
        (WidgetTester tester) async {
      final cart = Cart();
      final pricingRepository = PricingRepository();

      // Add six-inch sandwiches to cart
      final sandwich = Sandwich(
        id: 'test',
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
        description: '',
        available: true,
      );

      cart.add(sandwich, quantity: 3); // 3 * $7.00 = $21.00

      final testApp = MaterialApp(
        home: Scaffold(
          body: CartSummary(
            cart: cart,
            pricingRepository: pricingRepository,
          ),
        ),
      );

      await tester.pumpWidget(testApp);

      // Verify cart summary shows correct totals
      expect(find.text('Items: 3'), findsOneWidget);
      expect(find.text('\$21.00'), findsOneWidget);
    });

    testWidgets('CartSummary widget displays correct total for mixed items',
        (WidgetTester tester) async {
      final cart = Cart();
      final pricingRepository = PricingRepository();

      // Add different types of sandwiches
      final footlongSandwich = Sandwich(
        id: 'footlong',
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
        description: '',
        available: true,
      );

      final sixInchSandwich = Sandwich(
        id: 'sixinch',
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.white,
        description: '',
        available: true,
      );

      cart.add(footlongSandwich, quantity: 1); // 1 * $11.00 = $11.00
      cart.add(sixInchSandwich, quantity: 2); // 2 * $7.00 = $14.00
      // Total: 3 items, $25.00

      final testApp = MaterialApp(
        home: Scaffold(
          body: CartSummary(
            cart: cart,
            pricingRepository: pricingRepository,
          ),
        ),
      );

      await tester.pumpWidget(testApp);

      // Verify cart summary shows correct totals
      expect(find.text('Items: 3'), findsOneWidget);
      expect(find.text('\$25.00'), findsOneWidget);
    });
  });
}
