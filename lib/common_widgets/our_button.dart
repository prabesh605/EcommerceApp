import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({onPressed, String? text}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, padding: const EdgeInsets.all(12)),
    onPressed: onPressed,
    child: "$text".text.white.bold.make(),
  );
}
