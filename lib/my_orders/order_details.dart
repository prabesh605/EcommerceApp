import 'package:ecommerceapp/my_orders/components/order_place_details.dart';
import 'package:ecommerceapp/my_orders/components/order_status.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetail extends StatelessWidget {
  const OrdersDetail({super.key, this.data});
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Order Details".text.make(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
              color: Colors.red,
              icon: Icons.done,
              title: "placed",
              showDone: data['order_placed'],
            ),
            orderStatus(
              color: Colors.red,
              icon: Icons.done,
              title: "Confirmed",
              showDone: data['order_confirmed'],
            ),
            orderStatus(
              color: Colors.red,
              icon: Icons.done,
              title: "On Delivery",
              showDone: data['order_on_delivery'],
            ),
            orderStatus(
              color: Colors.red,
              icon: Icons.done,
              title: "Delivered",
              showDone: data['order_delivered'],
            ),
            const Divider(),
            10.heightBox,
            orderPlaceDetails(
                d1: data['order_code'],
                d2: data['shipping_method'],
                title1: 'Order code',
                title2: "Shipping Method"),
            orderPlaceDetails(
                d1: intl.DateFormat()
                    .add_yMd()
                    .format(data['order_date'].toDate()),
                d2: data['Payment_method'],
                title1: 'Order Date',
                title2: "Payment method"),
            orderPlaceDetails(
                d1: "Unpaid",
                d2: 'Order Placed',
                title1: 'Payment status',
                title2: "Delivery status"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Shipping Address".text.semiBold.make(),
                      "${data['order_by_name']}".text.make(),
                      "${data['order_by_email']}".text.make(),
                      "${data['order_by_address']}".text.make(),
                      "${data['order_by_city']}".text.make(),
                      "${data['order_by_state']}".text.make(),
                      "${data['order_by_phone']}".text.make(),
                      "${data['order_by_postalcode']}".text.make(),
                    ],
                  ),
                  SizedBox(
                    width: 130,
                    child: Column(
                      children: [
                        "Total Amount".text.semiBold.make(),
                        "${data['total_amount']}"
                            .text
                            .color(Colors.red)
                            .bold
                            .make()
                      ],
                    ),
                  )
                ],
              ),
            ),
            10.heightBox,
            "Ordered Product".text.size(16).semiBold.makeCentered(),
            10.heightBox,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                      title1: data['orders'][index]['title'],
                      title2: "Rs. ${data['orders'][index]['tprice']}",
                      d1: "${data['orders'][index]['qty']}x3",
                      d2: "Refunable",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: 30,
                        height: 20,
                        color: Color(data['orders'][index]['color']),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            )
                .box
                .outerShadowMd
                .white
                .margin(const EdgeInsets.symmetric(horizontal: 5))
                .make(),
          ],
        ),
      ),
    );
  }
}
