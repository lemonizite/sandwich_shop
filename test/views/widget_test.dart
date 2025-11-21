import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('App widget', () {
    testWidgets('App sets OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen interaction tests', () {
    testWidgets('Add to Cart button shows SnackBar with confirmation message',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      // Tap Add to Cart button (quantity starts at 1)
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add to Cart'));
      await tester.pumpAndSettle(); // Wait for SnackBar animation

      // Verify SnackBar appears with confirmation message
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.textContaining('Added 1'), findsOneWidget);
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
}
