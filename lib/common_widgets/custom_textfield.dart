import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextField({String? name, String? hint, ispass = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "$name".text.color(Colors.red).size(18).make(),
        5.heightBox,
        TextFormField(
          style: const TextStyle(fontSize: 18),
          obscureText: ispass,
          decoration: InputDecoration(
            hintText: "$hint",
            isDense: true,
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10), // Set border radius
            ),
          ),
        ).box.shadowSm.make()
      ],
    ),
  );
}
