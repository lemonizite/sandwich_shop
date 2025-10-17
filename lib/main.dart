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
        body: Center(
          child: Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(16.0),
            //width: 10,
            child: const OrderItemDisplay("Footlong", 5),
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
    return Text("$quantity $itemType sandwich(es): ${"🥪" * quantity}");
  }
}
