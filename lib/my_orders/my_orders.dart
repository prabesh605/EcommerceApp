import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Orders".text.make(),
      ),
      body: Container(
        color: Colors.orange,
      ),
    );
  }
}
