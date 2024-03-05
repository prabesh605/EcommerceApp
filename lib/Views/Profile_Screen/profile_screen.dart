import 'package:ecommerceapp/Views/Profile_Screen/components/details_card.dart';
import 'package:ecommerceapp/Views/auth_screen/login_screen.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/consts/list.dart';
import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:ecommerceapp/messages/messages.dart';
import 'package:ecommerceapp/my_orders/my_orders.dart';
import 'package:ecommerceapp/my_wishlist/my_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 208, 215),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        model5,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                      const Positioned(
                          bottom: 40, right: 8, child: Icon(Icons.edit))
                    ],
                  ),
                  10.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Dummy User".text.make(),
                        "customer@example.com".text.make()
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      await Get.put(AuthController()).signoutMethod(context);
                      Get.offAll(() => const LoginScreen());
                    },
                    child: "Logout".text.make(),
                  ),
                ],
              ),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  detailsCard(
                      count: "00",
                      title: "in your cart",
                      width: context.screenWidth / 3.4),
                  detailsCard(
                      count: "32",
                      title: "in your wishlist",
                      width: context.screenWidth / 3.4),
                  detailsCard(
                      count: "675",
                      title: "your orders",
                      width: context.screenWidth / 3.4),
                ],
              ),
              10.heightBox,
              //button section
              Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(
                            profileButtonsIcon[index],
                            width: 22,
                            height: 22,
                          ),
                          title: profileButtonsList[index].text.make(),
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const MyOrders());
                                break;
                              case 1:
                                Get.to(() => const MyWishlist());
                                break;
                              case 2:
                                Get.to(() => const Messages());
                                break;
                            }
                          },
                        );
                      },
                      separatorBuilder: ((context, index) => const Divider(
                            color: Colors.grey,
                          )),
                      itemCount: profileButtonsList.length),
                ],
              )
                  .box
                  .color(
                    const Color.fromARGB(255, 229, 208, 215),
                  )
                  .rounded
                  .padding(const EdgeInsets.all(12))
                  .shadowSm
                  .make()
            ],
          ),
        ),
      ),
    );
  }
}
