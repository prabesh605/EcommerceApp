import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderPlaceDetails({title1, d1, title2, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.semiBold.make(),
            "$d1".text.color(Colors.red).semiBold.make(),
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.semiBold.make(),
              "$d2".text.make(),
            ],
          ),
        ),
      ],
    ),
  );
}
