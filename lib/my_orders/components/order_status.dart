import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(child: "$title".text.make()),
          showDone
              ? const SizedBox(
                  child: Icon(
                    Icons.done,
                    color: Colors.red,
                  ),
                )
              : Container()
        ],
      ),
    ),
  );
}
