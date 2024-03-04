import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyWishlist extends StatelessWidget {
  const MyWishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Wishlist".text.make(),
      ),
      body: Container(
        color: Colors.pink,
      ),
    );
  }
}
