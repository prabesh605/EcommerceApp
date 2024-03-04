import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 228, 200, 209),
        automaticallyImplyLeading: false,
        title: "My Cart".text.makeCentered(),
      ),
      backgroundColor: const Color.fromARGB(255, 229, 208, 215),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: ["Cart is Empty!".text.size(26).make()],
        ),
      ),
    );
  }
}
