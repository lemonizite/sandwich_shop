import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sandwich Shop App",
      home: Scaffold(
        appBar: AppBar(title: const Text("Sandwich Counter")),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              color: Colors.blue,
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                alignment: WrapAlignment.center,
                children: const [
                  OrderItemDisplay("BLT", 3),
                  OrderItemDisplay("Club", 5),
                  OrderItemDisplay("Veggie", 2),
                  OrderItemDisplay("Ham", 4),
                  OrderItemDisplay("Turkey", 6),
                  OrderItemDisplay("Chicken", 3),
                  OrderItemDisplay("Tuna", 5),
                  OrderItemDisplay("Egg Salad", 2),
                  OrderItemDisplay("Roast Beef", 7),
                  OrderItemDisplay("Pastrami", 4),
                  OrderItemDisplay("Meatball", 3),
                  OrderItemDisplay("Grilled Cheese", 2),
                  OrderItemDisplay("Italian", 6),
                  OrderItemDisplay("Caprese", 3),
                  OrderItemDisplay("Buffalo Chicken", 5),
                  OrderItemDisplay("Pulled Pork", 4),
                  OrderItemDisplay("Philly Cheesesteak", 3),
                  OrderItemDisplay("Reuben", 2),
                  OrderItemDisplay("Cuban", 6),
                  OrderItemDisplay("Avocado Toast", 3),
                  OrderItemDisplay("Salmon", 2),
                  OrderItemDisplay("Shrimp", 4),
                  OrderItemDisplay("Lobster Roll", 1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final String itemType;
  final int quantity;

  const OrderItemDisplay(this.itemType, this.quantity, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$quantity $itemType sandwich(es): ${"🥪" * quantity}",
      style: TextStyle(
        color: const Color.fromARGB(255, 5, 90, 28),
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    );
  }
}
