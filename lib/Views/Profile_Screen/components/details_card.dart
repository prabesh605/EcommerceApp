import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget detailsCard({width, String? count, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.size(16).make(),
      5.heightBox,
      title!.text.make(),
    ],
  )
      .box
      .white
      .rounded
      .shadowSm
      .width(width)
      .padding(const EdgeInsets.all(4))
      .height(80)
      .make();
}
