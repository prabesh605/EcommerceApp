import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Views/Profile_Screen/components/details_card.dart';
import 'package:ecommerceapp/Views/Profile_Screen/edit_profileScreen.dart';
import 'package:ecommerceapp/Views/auth_screen/login_screen.dart';
import 'package:ecommerceapp/consts/firebase_consts.dart';
import 'package:ecommerceapp/consts/images.dart';
import 'package:ecommerceapp/consts/list.dart';
import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:ecommerceapp/controller/profile_controller.dart';
import 'package:ecommerceapp/messages/messages.dart';
import 'package:ecommerceapp/my_orders/my_orders.dart';
import 'package:ecommerceapp/my_wishlist/my_wishlist.dart';
import 'package:ecommerceapp/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 208, 215),
      body: StreamBuilder(
        stream: FirestoreService.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data!.docs[0];
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () => Column(
                    children: [
                      Row(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 160,
                                child: data['imageUrl'] == '' &&
                                        controller.profileImgPath.isEmpty
                                    ? Image.asset(
                                        profile1,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make()
                                    : data['imageUrl'] != '' &&
                                            controller.profileImgPath.isEmpty
                                        ? Image.network(
                                            data['imageUrl'],
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                            .box
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .make()
                                        : Image.file(
                                            File(controller
                                                .profileImgPath.value),
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                            .box
                                            .roundedFull
                                            .clip(Clip.antiAlias)
                                            .make(),
                              ),
                              Positioned(
                                bottom: 30,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => EditProfile(
                                        data: data,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.edit),
                                        Text("Edit "),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          10.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.bold.size(18).make(),
                                "${data['email']}".text.size(18).make()
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              await Get.put(AuthController())
                                  .signoutMethod(context);
                              Get.offAll(() => const LoginScreen());
                            },
                            child: "Logout".text.make(),
                          ),
                        ],
                      ),
                      20.heightBox,
                      FutureBuilder(
                          future: FirestoreService.getCounts(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              var countData = snapshot.data;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  detailsCard(
                                      count: countData[0].toString(),
                                      title: "in your cart",
                                      width: context.screenWidth / 3.4),
                                  detailsCard(
                                      count: countData[1].toString(),
                                      title: "in your wishlist",
                                      width: context.screenWidth / 3.4),
                                  detailsCard(
                                      count: countData[2].toString(),
                                      title: "your orders",
                                      width: context.screenWidth / 3.4),
                                ],
                              );
                            }
                          }),

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
                              separatorBuilder: ((context, index) =>
                                  const Divider(
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
        },
      ),
    );
  }
}
