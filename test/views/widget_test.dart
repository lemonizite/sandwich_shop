import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  group('App widget', () {
    testWidgets('App sets OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });

  group('OrderScreen interaction tests', () {
    testWidgets(
        '"Sandwich Counter" text and initial sandwich quantity are displayed',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // OrderScreen uses lowercase sandwich type and includes bread type in display
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
      expect(find.text('Sandwich Counter'), findsOneWidget);
    });

    testWidgets('Tapping add button increases quantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      // Rebuild the widget after the state has changed.
      await tester.pump();
      expect(find.text('1 white footlong sandwich(es): 🥪'), findsOneWidget);
    });

    testWidgets('Tapping remove button decreases quantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pump();
      // Verify the quantity is increased to 1.
      expect(find.text('1 white footlong sandwich(es): 🥪'), findsOneWidget);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
      await tester.pump();
      // Verify the quantity is decreased back to 0.
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('Quantity does not go below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Verify the initial quantity is 0.
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
      await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
      await tester.pump();
      // Verify the quantity remains at 0, as it shouldn't go negative.
      expect(find.text('0 white footlong sandwich(es): '), findsOneWidget);
    });

    testWidgets('Quantity does not exceed maxQuantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Tap the 'Add' button more times than the maximum allowed quantity.
      for (int i = 0; i < 10; i++) {
        await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
        await tester.pump();
      }
      // Verify the quantity does not exceed the maximum of 5.
      expect(find.text('5 white footlong sandwich(es): 🥪🥪🥪🥪🥪'),
          findsOneWidget);
    });

    testWidgets('Toggling the Switch changes sandwich type',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      // Initially, should show 'footlong' with bread type (default is white)
      expect(find.textContaining('white footlong sandwich'), findsOneWidget);
      // Find the sandwich-type Switch (the first Switch in the widget tree) and tap it
      await tester.tap(find.byType(Switch).first);
      await tester.pump();
      // Now, should show 'six-inch' with bread type
      expect(find.textContaining('white six-inch sandwich'), findsOneWidget);
      // Tap again to toggle back
      await tester.tap(find.byType(Switch).first);
      await tester.pump();
      // Should show 'footlong' again
      expect(find.textContaining('white footlong sandwich'), findsOneWidget);
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
