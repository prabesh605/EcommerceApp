import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "My Messages".text.make(),
      ),
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
