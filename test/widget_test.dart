import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('App', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen - Quantity', () {
    testWidgets('shows initial title', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('increments quantity when increment button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Quantity starts at 1, increment to 2
      await tester.tap(find.widgetWithIcon(IconButton, Icons.add).first);
      await tester.pump();
      // Should show quantity of 2
      expect(find.text('2'), findsWidgets);
    });

    testWidgets('decrements quantity when decrement button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Quantity starts at 1, decrement to 0
      await tester.tap(find.widgetWithIcon(IconButton, Icons.remove).first);
      await tester.pump();
      // Should show quantity of 0
      expect(find.text('0'), findsWidgets);
    });

    testWidgets('does not decrement below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Quantity starts at 1, decrement twice
      await tester.tap(find.widgetWithIcon(IconButton, Icons.remove).first);
      await tester.pump();
      await tester.tap(find.widgetWithIcon(IconButton, Icons.remove).first);
      await tester.pump();
      // Should still be 0
      expect(find.text('0'), findsWidgets);
    });
  });

  group('OrderScreen - Controls', () {
    testWidgets('Switch and DropdownMenu widgets are present',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Verify Switch for size toggle
      expect(find.byType(Switch), findsOneWidget);
      // Verify DropdownMenu widgets exist (they use specific type parameters)
      expect(find.byWidgetPredicate((widget) {
        return widget.runtimeType.toString().contains('DropdownMenu');
      }), findsWidgets);
    });
  });

  group('StyledButton', () {
    testWidgets('renders with icon and label', (WidgetTester tester) async {
      const testButton = StyledButton(
        onPressed: null,
        icon: Icons.add,
        label: 'Test Add',
        backgroundColor: Colors.blue,
      );
      const testApp = MaterialApp(
        home: Scaffold(body: testButton),
      );
      await tester.pumpWidget(testApp);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.text('Test Add'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('OrderItemDisplay', () {
    testWidgets('shows correct text and note for zero sandwiches',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 0,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'No notes added.',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
      expect(find.text('Note: No notes added.'), findsOneWidget);
    });

    testWidgets('shows correct text and emoji for three sandwiches',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 3,
        itemType: 'footlong',
        breadType: BreadType.white,
        orderNote: 'No notes added.',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(
          find.text('3 white footlong sandwich(es): 🥪🥪🥪'), findsOneWidget);
      expect(find.text('Note: No notes added.'), findsOneWidget);
    });

    testWidgets('shows correct bread and type for two six-inch wheat',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 2,
        itemType: 'six-inch',
        breadType: BreadType.wheat,
        orderNote: 'No pickles',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(find.text('2 wheat six-inch sandwich(es): 🥪🥪'), findsOneWidget);
      expect(find.text('Note: No pickles'), findsOneWidget);
    });

    testWidgets('shows correct bread and type for one wholemeal footlong',
        (WidgetTester tester) async {
      const widgetToBeTested = OrderItemDisplay(
        quantity: 1,
        itemType: 'footlong',
        breadType: BreadType.wholemeal,
        orderNote: 'Lots of lettuce',
      );
      const testApp = MaterialApp(
        home: Scaffold(body: widgetToBeTested),
      );
      await tester.pumpWidget(testApp);
      expect(
          find.text('1 wholemeal footlong sandwich(es): 🥪'), findsOneWidget);
      expect(find.text('Note: Lots of lettuce'), findsOneWidget);
    });
  });

  group('CartSummary Widget Tests', () {
    testWidgets('CartSummary widget displays initial empty state',
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
